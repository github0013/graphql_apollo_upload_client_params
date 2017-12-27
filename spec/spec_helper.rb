require "bundler/setup"
require "graphql_apollo_upload_client_params"
require "pry"

Dir[Pathname(__FILE__).dirname.join("support/*.rb")].each do |f|
  require f
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"
  config.filter_run_including focus: true
  config.run_all_when_everything_filtered = true

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
