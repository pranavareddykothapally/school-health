# frontend/spec/spec_helper.rb
require 'bundler/setup'
require 'dotenv'
require 'watir'
require 'rspec'

# loads the .env from project root
Dotenv.load(File.expand_path('../../.env', __dir__))

RSpec.configure do |config|
  # ...
end
