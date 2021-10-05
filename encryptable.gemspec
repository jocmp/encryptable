# frozen_string_literal: true

require_relative "lib/encryptable/version"

Gem::Specification.new do |spec|
  spec.name = "encryptable"
  spec.authors = ["jocmp"]
  spec.version = Encryptable::VERSION
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")
  spec.summary = "Gem'ed demo of the encryptable module shown at RubyKaigi 2021"

  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.executables = ["encryptable"]
  spec.require_paths = ["lib"]
end
