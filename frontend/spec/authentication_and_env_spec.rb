# spec/authentication_and_env_spec.rb
require 'dotenv'
require 'rspec'

RSpec.describe 'Environment and Configuration' do
  context 'TC 010: Load environment variables from .env' do
    it 'fails if .env is missing' do
      expect {
        # simulate missing .env by loading a bad path
        Dotenv.load('.env.missing').fetch('BASE_URL')
      }.to raise_error(KeyError)
    end

    it 'loads required variables' do
      # load the real .env into ENV
      Dotenv.load('.env')
      %w[BASE_URL USERNAME PASSWORD].each do |key|
        value = ENV[key]
        expect(value).to be_a(String), "Expected ENV['#{key}'] to be a String, got \#{value.class}"
        expect(value).not_to be_empty, "Expected ENV['#{key}'] not to be empty"
      end
    end
  end

  context 'TC 002: missing USERNAME in .env' do
    it 'raises an ArgumentError when USERNAME is absent' do
      Dotenv.load('.env')
      ENV.delete('USERNAME')
      expect {
        # your login helper should validate presence and raise
        load File.expand_path('../../bin/declare.rb', __dir__)
      }.to raise_error(ArgumentError, /USERNAME missing/)
    end
  end
end