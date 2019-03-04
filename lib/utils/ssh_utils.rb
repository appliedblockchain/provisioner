require 'open3'

module SSHUtils

  # ssh utils

  def ssh_exe(cmd)
    exe "ssh -t #{IP_CURR} \"#{cmd}\""
  end

  def ssh_exe_user(cmd, user: "ubuntu")
    exe "ssh -t #{user}@#{IP_CURR} 'sudo -u root #{cmd}'"
  end

  def ssh_exe_out(cmd)
    exe "ssh -t #{IP_CURR} '#{cmd}' && echo '<OK>'"
  end

  def ssh_all_exe_su(cmd)
    threads = []
    IPS.each do |swarm_node_ip|
      threads << Thread.new do
        exe "ssh #{swarm_node_ip} \"#{cmd}\""
      end
    end
    threads.map &:join
  end

  def ssh_all_exe_su_user(cmd, user: "ubuntu")
    threads = []
    IPS.each do |swarm_node_ip|
      threads << Thread.new do
        exe "ssh #{user}@#{swarm_node_ip} 'sudo su -c \"#{cmd}\"'"
      end
    end
    threads.map &:join
  end

  SSHCmd = -> (ip, cmd, open3) {
    open3 = !!(open3 == :open3)
    exe "ssh -t #{ip} \"#{cmd}\"", open3: open3
  }

end
