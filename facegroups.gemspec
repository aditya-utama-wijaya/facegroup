# frozen_string_literal: true
$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require 'facegroups/version'

Gem::Specification.new do |s|
  s.name = 'facegroups'
  s.version = FaceGroups::VERSION

  s.summary = 'Gets posted content from public Facebook groups'
  s.description = 'Extracts feed, postings, and attachments from FB groups'
  s.authors = ['Aditya Utama Wijaya']
  s.email = ['adityautamawijaya@gmail.com']

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec/*`.split("\n")
  s.executables << 'facegroups'

  s.add_runtime_dependency 'http', '~> 2.0'

  s.add_development_dependency 'minitest', '~> 5.9'
  s.add_development_dependency 'minitest-rg', '~> 5.2'
  s.add_development_dependency 'rake', '~> 11.3'
  s.add_development_dependency 'vcr', '~> 3.0'
  s.add_development_dependency 'webmock', '~> 2.1'
  s.add_development_dependency 'simplecov', '~> 0.12'
  s.add_development_dependency 'flog', '~> 4.4'
  s.add_development_dependency 'flay', '~> 2.8'
  s.add_development_dependency 'rubocop', '~> 0.42'

  s.homepage		= 'https://github.com/aditya-utama-wijaya/facegroups'
  s.license			= 'MIT'
end
