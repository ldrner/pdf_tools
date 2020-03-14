# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pdf_tools/version"

Gem::Specification.new do |spec|
  spec.name          = 'pdf_tools'
  spec.version       = PdfTools::VERSION
  spec.authors       = ['Ilya K.']
  spec.email         = ['ldrner@gmail.com']

  spec.summary       = 'Ruby wrapper for the PDF Tools command-line utils'
  spec.description   = 'Ruby wrapper for the PDF Tools command-line utils. https://www.pdf-tools.com/'
  spec.homepage      = 'https://github.com/ldrner/pdf_tools'
  spec.license       = 'MIT'

  # spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  # spec.metadata['source_code_uri'] = "TODO: Put your gem's public repo URL here."
  # spec.metadata['changelog_uri'] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'

  spec.require_paths = ['lib']
  spec.required_ruby_version = '~> 2.3'

  spec.add_development_dependency 'bundler', '>= 1.17'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.7'
  spec.add_development_dependency 'simplecov'
end
