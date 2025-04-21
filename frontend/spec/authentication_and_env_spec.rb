# spec/authentication_and_env_spec.rb
require 'dotenv'
require 'watir'
require 'rspec'

# TC 010: Load environment variables from .env
RSpec.describe 'Environment and Configuration (TC 010)' do
  it 'fails if .env is missing' do
    # simulate missing .env by loading a bad path
    expect {
      Dotenv.load('.env.missing').fetch('BASE_URL')
    }.to raise_error(KeyError)
  end

  it 'loads required variables' do
    Dotenv.load('.env')
    %w[BASE_URL USERNAME PASSWORD].each do |var|
      expect(ENV[var]).not_to be_nil, "Expected #{var} to be set in .env"
    end
  end
end

# spec/login_spec.rb
RSpec.describe 'User Authentication and Login (TC 001 & TC 002)' do
  before(:all) do
    Dotenv.load('.env')
    @browser = Watir::Browser.new(
      :chrome,
      headless: ENV.fetch('HEADLESS', 'false') == 'true'
    )
    @base = ENV.fetch('BASE_URL')
  end

  after(:all) do
    @browser&.close
  end

  context 'TC 001: valid credentials' do
    it 'logs in and lands on the dashboard' do
      @browser.goto @base
      @browser.text_field(id: 'username').set ENV['USERNAME']
      @browser.text_field(id: 'password').set ENV['PASSWORD']
      @browser.button(id: 'login').click

      # adjust these selectors to match your actual page
      expect(@browser.url).to include('/dashboard')
      expect(@browser.h1(text: /Dashboard/i)).to exist
    end
  end

  context 'TC 002: missing USERNAME in .env' do
    it 'raises an ArgumentError when USERNAME is absent' do
      ENV.delete('USERNAME')
      expect {
        # your login helper should validate presence and raise
        load 'declare.rb'
      }.to raise_error(ArgumentError, /USERNAME missing/)
    end
  end
end
