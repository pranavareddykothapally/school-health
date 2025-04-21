#!/usr/bin/env ruby
require 'dotenv'
require 'watir'

# Load env
Dotenv.load(File.expand_path('.env', __dir__))

# Validate required variables (TC 010 + TC 002)
%w[BASE_URL USERNAME PASSWORD].each do |var|
  raise ArgumentError, "#{var} missing" unless ENV[var]&.strip&.length&.positive?
end

# Launch browser & login (TC 001)
browser = Watir::Browser.new :chrome,
  headless: ENV['HEADLESS'] == 'true'

browser.goto ENV['BASE_URL']

# *** Update these selectors to match your actual HTML ***
browser.text_field(id: 'user').set     ENV['USERNAME']
browser.text_field(id: 'pass').set     ENV['PASSWORD']
browser.button(text: 'Sign In').click

# Verify dashboard
unless browser.url.include?('/dashboard')
  browser.screenshot.save("tmp/login_failure_#{Time.now.to_i}.png")
  raise "Login did not reach /dashboard (now at #{browser.url})"
end

puts 'Login successful'
browser.quit
