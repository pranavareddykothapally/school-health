#!/usr/bin/env ruby
require 'dotenv'
require 'watir'

# 1) load .env
Dotenv.load(File.expand_path('.env', __dir__))

# 2) validate presence of required vars
%w[BASE_URL USERNAME PASSWORD].each do |var|
  raise ArgumentError, "#{var} missing" unless ENV[var]&.strip&.length&.positive?
end

# 3) open browser & perform login
browser = Watir::Browser.new :chrome, headless: ENV['HEADLESS'] == 'true'
browser.goto ENV['BASE_URL']

# 4) use the actual selectors from your index.html!
#    (update :id or :name or :class_name to match your HTML)
username_field = browser.text_field(id:   'username')
password_field = browser.text_field(id:   'password')
login_button   = browser.button(id:      'login')

username_field.set ENV['USERNAME']
password_field.set ENV['PASSWORD']
login_button.click

# 5) verify dashboard
unless browser.url.include?('/dashboard')
  browser.screenshot.save("tmp/login_failure_#{Time.now.to_i}.png")
  raise "Login didn’t reach /dashboard, ended up at #{browser.url}"
end

puts "Login successful"
browser.quit
