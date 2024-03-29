[![Gem Version](https://badge.fury.io/rb/pdf_tools.svg)](https://badge.fury.io/rb/pdf_tools)
[![RuboCop](https://github.com/ldrner/pdf_tools/actions/workflows/rubocop.yml/badge.svg)](https://github.com/ldrner/pdf_tools/actions/workflows/rubocop.yml)
[![Maintainability](https://api.codeclimate.com/v1/badges/b4d61ab4a390d00dd346/maintainability)](https://codeclimate.com/github/ldrner/pdf_tools/maintainability)


# PdfTools

Ruby wrapper for the PDF Tools command-line utils.
[https://www.pdf-tools.com/](https://www.pdf-tools.com/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pdf_tools'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pdf_tools

## Usage

Native support for next tools are available:
* 3-Heights™ PDF Merge Split
* 3-Heights™ Image to PDF Converter

```ruby
  PdfTools::Tool::ImageToPdf.new do |tool|
    tool.lk "license key"
    tool.f
    tool << "input.tif"
    tool << "output.pdf"
  end
```

```ruby
  PdfTools::Tool::MergeSplit.new do |tool|
    tool.lk "license key"
    tool.m
    tool << "in1.pdf"
    tool.ot "Bookmark"
    tool << "in2.pdf"
    tool << "out.pdf"
  end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ldrner/pdf_tools.
