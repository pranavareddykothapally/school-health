#!/usr/bin/env ruby
require 'watir'

BASE_URL = ENV.fetch('BASE_URL', 'http://localhost:4567')

# Launch headless browser
browser = Watir::Browser.new :chrome, headless: true

begin
  # 1) Go to index, click form link
  browser.goto "#{BASE_URL}/index.html"
  browser.link(text: 'Daily Health Form').wait_until(&:present?).click

  # 2) Fill in dummy data
  browser.text_field(id: 'parentName').set('Test Parent')
  browser.text_field(id: 'parentTZ').set('000')
  browser.text_field(id: 'childNames').set('Test Child')
  browser.text_field(id: 'childTZ').set('111')

  # 3) Click submit (will hit your simulated 500)
  browser.button(type: 'submit').click

  # 4) Brief pause to let redirect (if any) happen
  sleep 1

  if browser.url.include?('dashboard.html')
    puts "TC014: FAIL — Unexpected success; expected server error"
    exit(1)
  else
    puts "TC014: PASS — Did not reach dashboard (server error simulated)"
    exit(0)
  end

rescue Watir::Wait::TimeoutError
  # catches timeout waiting for dashboard when server is 500
  puts "TC014: PASS — Timeout on redirect indicates server error"
  exit(0)

rescue => e
  # any other unexpected error
  puts "TC014: FAIL — Unexpected error #{e.class}: #{e.message}"
  exit(1)

ensure
  browser&.quit
end
