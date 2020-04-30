require_relative 'utils/ssh_utils'

module Utils

  include SSHUtils

  def exe(cmd, dir: nil, open3: false)
    cd_cmd = "cd #{dir} && " if dir
    cmd = "#{cd_cmd}#{cmd}"
    puts "executing: #{cmd}"
    unless open3
      out = system cmd
    else
      out, err, st = Open3.capture3 cmd
    end
    puts out
    puts "#{err}\n"
    out
  end

  def rexe(cmd)
    puts "executing: #{cmd}"
    out = `#{cmd}`
    puts out
    puts "#{err}\n"
    out
  end

end
