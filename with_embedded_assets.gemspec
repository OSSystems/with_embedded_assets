# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'with_embedded_assets/version'

Gem::Specification.new do |gem|
  gem.name          = "with_embedded_assets"
  gem.version       = WithEmbeddedAssets::VERSION
  gem.authors       = ["O.S. Systems Softwares LTDA."]
  gem.email         = ["contato@ossystems.com.br"]
  gem.description   = %q{Embeds assets from Rails directly into HTML}
  gem.summary       = <<-SUMMARY
    This gem changes the behaviour of the Ruby on Rails asset pipeline to
    directly embedding CSS, JS and images files to the generated HTML.
  SUMMARY
  gem.homepage      = "https://github.com/OSSystems/with_embedded_assets"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'rails', ['~> 4.0']
end
