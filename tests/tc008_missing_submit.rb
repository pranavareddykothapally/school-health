#!/usr/bin/env ruby
require 'watir'

BASE_URL = ENV.fetch('BASE_URL', 'http://localhost:4567')

# 1) Start headless browser
browser = Watir::Browser.new :chrome, headless: true

begin
  # 2) Go to the form page
  browser.goto "#{BASE_URL}/antigen_form.html"

  # 3) Verify the submit button is actually missing
  if browser.button(type: 'submit').exists?
    puts "TC008: FAIL — Submit button still present; remove or rename it in your HTML to simulate TC008."
    exit(1)
  end

  # 4) Try clicking the (non‑existent) button
  begin
    browser.button(type: 'submit').click
    # If click somehow succeeds, that’s a fail:
    puts "TC008: FAIL — Click succeeded unexpectedly."
    exit(1)
  rescue Watir::Exception::UnknownObjectException, Watir::Wait::TimeoutError
    # Expected path
    puts "TC008: PASS — Missing-submit button exception caught."
    exit(0)
  end

rescue Selenium::WebDriver::Error::WebDriverError => e
  # Unexpected driver error
  puts "TC008: FAIL — Browser error: #{e.class}: #{e.message}"
  exit(1)
ensure
  browser&.quit
end
