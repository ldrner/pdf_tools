# frozen_string_literal: true

require "open3"

module PdfTools
  # Send commands to the shell
  class Shell
    def run(command, **options)
      stdout, stderr, status = execute(command)

      if status != 0
        raise PdfTools::Error, "Command `#{command.join(" ")}` failed!\n  Error: #{stderr}"
      end

      $stderr.print(stderr) unless options[:stderr] == false

      [stdout, stderr, status]
    end

    def execute(command)
      stdout, stderr, status =
        Open3.popen3(*command) do |stdin, stdout, stderr, wait_thr|
          [stdin, stdout, stderr].each(&:binmode)
          stdout_reader = Thread.new { stdout.read }
          stderr_reader = Thread.new { stderr.read }

          [stdout_reader.value, stderr_reader.value, wait_thr.value]
        end

      [stdout, stderr, status.exitstatus]
    rescue Errno::ENOENT, IOError
      ["", "executable not found: \"#{command.first}\"", 127]
    end
  end
end
