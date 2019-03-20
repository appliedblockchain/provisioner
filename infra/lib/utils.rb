module Utils

  def error_and_exit(message:, error:)
    puts "ERROR!"
    puts "  #{message}\n\n"
    puts "Error message: #{error.message.inspect}"
    puts "(error: #{error.class})"
    puts "exiting...\n\n"
    exit 1
  end

end
