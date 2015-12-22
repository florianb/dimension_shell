# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'dimension_shell/version'

Gem::Specification.new do |s|
  s.name        = "dimension_shell"
  s.version     = DimensionShell::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Florian Breisch"]
  s.email       = ["florian.breisch@mindkeeper.solutions"]
  s.homepage    = "https://github.com/florianb/dimension_shell"
  s.summary     = "A tiny ssh-wrapper to address your virtual servers in the Dimenson Data Public Cloud by their name."
  #s.description = ""
  s.licenses    = ["GPL-3.0"]

  s.required_rubygems_version = ">= 1.3.6"

  s.add_runtime_dependency "bundler"

  s.files        = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.md ROADMAP.md CHANGELOG.md)
  s.executables  = ['dsh']
  s.require_path = 'lib'
end
