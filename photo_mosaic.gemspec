# frozen_string_literal: true
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "photo_mosaic/version"

Gem::Specification.new do |spec|
  spec.name          = "photo_mosaic"
  spec.version       = PhotoMosaic::VERSION
  spec.authors       = ["Axel Molina"]
  spec.email         = ["axel.molina@gmail.com"]
  spec.summary       = "Creates Photo Mosaics out of many small images to match a target image"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 3.0.1")

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = File.directory?(".git") ? `git ls-files`.split($/) : Dir.glob("**/*")
  spec.bindir        = "exe"
  spec.executables   = ["photo_mosaic"]
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "bundler"
  spec.add_dependency "zeitwerk"
  spec.add_dependency "mini_magick"
  spec.add_dependency "ruby-progressbar"
  spec.add_dependency "wisper"

  # For more information and docs about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
