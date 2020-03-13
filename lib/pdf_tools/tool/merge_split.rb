# frozen_string_literal: true

module PdfTools
  class Tool
    # Wrapper for 3-Heights(TM) Split and merge PDF documents Shell
    # @see https://www.pdf-tools.com/public/downloads/manuals/PdfSplitMergeShell.pd
    #
    # Return Codes
    # 0 Success.
    # 1 Couldn't open input file.
    # 2 PDF output file could not be created.
    # 3 Error with given options, e.g. too many parameters.
    # 4 Generic processing error.
    # 10 License error, e.g. invalid license key
    class MergeSplit < PdfTools::Tool
      TOOL_NAME = 'pdfsplmrg'

      def initialize(*args)
        super(TOOL_NAME, *args)
      end
    end
  end
end
