require 'open3'

module SSHUtils

  def ssh_exe(cmd)
    exe "ssh -t root@#{IP_CURR} \"#{cmd}\""
  end

  def ssh_exe_user(cmd, user: USER)
    exe "ssh -t #{user}@#{IP_CURR} 'sudo -u root #{cmd}'"
  end

  def ssh_exe_out(cmd)
    exe "ssh -t root@#{IP_CURR} '#{cmd}' && echo '<OK>'"
  end

  def ssh_all_exe_su(cmd)
    threads = []
    IPS.each do |swarm_node_ip|
      threads << Thread.new do
        exe "ssh root@#{swarm_node_ip} \"#{cmd}\""
      end
    end
    threads.map &:join
  end

  def ssh_all_exe_su_user(cmd, user: USER)
    threads = []
    IPS.each do |swarm_node_ip|
      threads << Thread.new do
        exe "ssh #{user}@#{swarm_node_ip} 'sudo su -c \"#{cmd}\"'"
      end
    end
    threads.map &:join
  end

  SSHCmd = -> (ip, cmd, open3=nil, no_abort=nil) {
    open3 = !!(open3 == :open3)
    abort_on_fail = no_abort != :no_abort
    exe "ssh -t root@#{ip} \"#{cmd}\"", open3: open3, abort_on_fail: abort_on_fail
  }

end
