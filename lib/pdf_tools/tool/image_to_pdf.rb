# frozen_string_literal: true

module PdfTools
  class Tool
    # Wrapper for 3-Heights(TM) Image to PDF Converter Shell
    # @see https://www.pdf-tools.com/public/downloads/manuals/Image2PdfShell.pdf
    #
    # Return Codes
    # 0 Success
    # 1 Input File could not be opened or invalid parameters
    # 2 The PDF Output File could not be written
    # 3 Option error
    # 4 OCR error
    # 5 Decode errors
    # 10 License error
    # none Information (stdout) "Done."
    class ImageToPdf < PdfTools::Tool
      TOOL_NAME = "img2pdf"

      def initialize(*args)
        super(TOOL_NAME, *args)
      end
    end
  end
end
