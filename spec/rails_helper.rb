require "spec_helper"
require File.expand_path("../config/environment", __dir__)
ENV["RAILS_ENV"] ||= "test"
abort("The Rails environment is running in production mode!") if Rails.env.production?

require "rspec/rails"
# Dir[Rails.root.join("spec", "support", "**", "*.rb")].sort.each { |f| require f }

RSpec.configure do |config|
  config.use_active_record = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before(:suite) do
    Rails.application.load_seed
  end

  config.before(:each, type: :request) do
    host! "localhost"
  end
end
