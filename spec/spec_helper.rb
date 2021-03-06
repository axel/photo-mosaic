# frozen_string_literal: true

require "photo_mosaic"
require "simplecov"
require "wisper/rspec/matchers"

RSpec.configure do |config|
  config.include(Wisper::RSpec::BroadcastMatcher)
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
