require_relative 'utils/ssh_utils'

module Utils

  include SSHUtils

  def exe(cmd, dir: nil, open3: false, abort_on_fail: true)
    cd_cmd = "cd #{dir} && " if dir
    cmd = "#{cd_cmd}#{cmd}"
    puts "executing: #{cmd}"
    unless open3
      out = system cmd
      raise "BashCommandFailedError - latest shell command failed, aborting - command: #{cmd.inspect}" if !out && abort_on_fail
    else
      out, err, st = Open3.capture3 cmd
    end
    puts out
    puts "ERROR: #{err}\n" if err
    raise "BashCommandFailedError - latest shell command failed, aborting - command: #{cmd.inspect}" if err && abort_on_fail
    out
  end

end
