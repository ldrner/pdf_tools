# frozen_string_literal: true

require "pdf_tools/shell"

module PdfTools
  # Abstract class that wraps command-line tools.
  #
  # @example
  #   PdfTools::Tool::ImageToPdf.new do |tool|
  #     tool.lk "license key"
  #     tool.f
  #     tool << "input.tif"
  #     tool << "output.pdf"
  #   end
  class Tool
    KEY_VALUE_OPTIONS = %w[i]

    # Execute the command.
    #
    # @example
    #   version = PdfTools::Tool::ImageToPdf.new { |b| b.version }
    #   puts version
    #
    # @return [PdfTools::Tool, String] If no block is given, returns an
    #   instance of the tool, if block is given, returns the command output.
    def self.new(*args)
      instance = super(*args)

      if block_given?
        yield instance
        instance.call
      else
        instance
      end
    end

    attr_reader :name, :args

    def initialize(name)
      @name = name
      @args = []
    end

    # Build and execute the command.
    #
    # @example
    #   img2pdf = PdfTools::Tool::ImageToPdf.new
    #   img2pdf.d(150)
    #   img2pdf << "input.tif"
    #   img2pdf << "output.pdf"
    #   img2pdf.call # executes `img2pdf -d 150 input.tif output.pdf`
    #
    # @example
    #   img2pdf = PdfTools::Tool::ImageToPdf.new
    #
    #   img2pdf.call do |stdout, stderr, status|
    #     # ...
    #   end
    #
    # @yield [Array] yields stdout, stderr, exit status (optional)
    #
    # @return [String] the output of the command
    def call(*args)
      options = args[-1].is_a?(Hash) ? args.pop : {}

      options[:stderr] = false if block_given?

      shell = PdfTools::Shell.new
      stdout, stderr, status = shell.run(command, **options)
      yield stdout, stderr, status if block_given?

      stdout.chomp("\n")
    end

    # The built command as array.
    #
    # @return [Array<String>]
    #
    # @example
    #   img2pdf = PdfTools::Tool::ImageToPdf.new
    #   img2pdf.d(150)
    #   img2pdf << "input.tif"
    #   img2pdf << "output.pdf"
    #   img2pdf.command #=> ["img2pdf", "-d", "150", "input.tif", "output.pdf"]
    def command
      [*name, *args]
    end

    # Append raw options.
    #
    # @return [self]
    def <<(arg)
      args << arg.to_s
      self
    end

    # Merge a list of raw options.
    #
    # @return [self]
    def merge!(add_args)
      add_args.each { |arg| self << arg }
      self
    end

    # Define option methods with key=value args.
    # For Ex. Set Document Information  -i <key=value>
    #
    # @example
    #   tool = PdfTools::Tool::ImageToPdf.new
    #   tool.i(:title => "My Title", :author => "My Name")
    #   tool << 'image.jpg'
    #   tool << 'output.pdf'
    KEY_VALUE_OPTIONS.each do |option|
      define_method(option.tr("-", "_")) do |hash = {}|
        hash.flat_map { |k, v| ["-#{option}", [k.capitalize, "\"#{v}\""].join("=")] }
          .each { |el| self << el }
        self
      end
    end

    # Any missing method will be transformed into a CLI option
    #
    # @example
    #   licmgr = PdfTools::Tool.new("licmgr")
    #   licmgr.<< "info"
    #   licmgr << "your license key"
    #   licmgr.command #=> ["licmgr", "info", "your license key"]
    def method_missing(name, *args)
      option = "-#{name.to_s.tr("_", "-")}"
      self << option
      merge!(args)
      self
    end

    def self.available_options
      tool = new
      tool << "-version"

      help_page = tool.call(stderr: false)
      available_options = help_page.scan(/^\s+-[a-z-]+/).map(&:strip)
      available_options.map { |o| o[1..].tr("-", "_") }
    end
  end
end

require "pdf_tools/tool/image_to_pdf"
require "pdf_tools/tool/merge_split"
