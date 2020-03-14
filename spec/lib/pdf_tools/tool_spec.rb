# frozen_string_literal: true

require 'spec_helper'

RSpec.describe PdfTools::Tool do
  subject(:tool) { PdfTools::Tool::ImageToPdf.new }
  let(:tool_name) { PdfTools::Tool::ImageToPdf::TOOL_NAME }

  describe '#call' do
    it 'calls the shell to run the command' do
      tool.version
      output = tool.call
      expect(output).to start_with('3-Heights(TM) Image to PDF Converter Shell')
    end

    it 'accepts a block, and yields stdin, stdout and exit status' do
      allow_any_instance_of(PdfTools::Shell).to receive(:execute).and_return(['stdout', 'stderr', 0])
      expect { |block| tool.call(&block) }.to yield_with_args('stdout', 'stderr', 0)
      expect(tool.call).to eq('stdout')
    end
  end

  describe '#new' do
    it 'accepts a block, and immediately executes the command' do
      output = described_class.new(tool_name) do |builder|
        builder.version
      end
      expect(output).to start_with('3-Heights(TM) Image to PDF Converter Shell')
    end
  end

  describe '#command' do
    it 'includes the executable and the arguments' do
      allow(tool).to receive(:args).and_return(%w[-list Command])
      expect(tool.command).to eq([tool_name, '-list', 'Command'])
    end
  end

  describe '#<<' do
    it 'adds argument to the args list' do
      tool << 'foo' << 'bar' << 123
      expect(tool.args).to eq %w[foo bar 123]
    end
  end

  describe '#merge!' do
    it 'adds arguments to the args list' do
      tool << 'pre-existing'
      tool.merge! ['foo', 123]
      expect(tool.args).to eq(%w[pre-existing foo 123])
    end
  end

  describe '#i' do
    it 'adds proper key=value args' do
      tool.i(title: 'My Title', author: 'My Name')
      expect(tool.args).to eq(['-i', "Title=\"My Title\"", '-i', "Author=\"My Name\""])
    end
  end

  describe '#method_missing' do
    it 'adds options' do
      tool.foo_bar('baz')
      expect(tool.args).to eq %w[-foo-bar baz]
    end
  end
end
