# frozen_string_literal: true

require 'spec_helper'

RSpec.describe PdfTools::Shell do
  subject { described_class.new }

  describe '#run' do
    it 'calls #execute with the command' do
      expect(subject).to receive(:execute).and_call_original
      subject.run(%w[img2pdf version])
    end

    it 'returns stdout, stderr and status' do
      allow(subject).to receive(:execute).and_return(['stdout', 'stderr', 0])
      output = subject.run(%w[foo])
      expect(output).to eq ['stdout', 'stderr', 0]
    end

    it 'uses stderr for error messages' do
      allow(subject).to receive(:execute).and_return(['', 'stderr', 1])
      expect { subject.run(%w[foo]) }
        .to raise_error(PdfTools::Error, /`foo`.*stderr/m)
    end

    it 'raises an error when executable wasn\'t found' do
      allow(subject).to receive(:execute).and_return(['', 'not found', 127])
      expect { subject.run(%w[foo]) }
        .to raise_error(PdfTools::Error, /not found/)
    end
  end
end
