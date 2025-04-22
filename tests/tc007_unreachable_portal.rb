#!/usr/bin/env ruby
require 'watir'

BASE_URL = 'http://localhost:9999'   # intentionally wrong

begin
  browser = Watir::Browser.new :chrome, headless: true

  # Attempt navigation; will raise on connection refused
  browser.goto "#{BASE_URL}/index.html"

  # If we get here, the portal was reachable—fail the test
  puts "TC007: FAIL — Portal was reachable, expected unreachable"
  exit(1)

rescue Selenium::WebDriver::Error::WebDriverError, Errno::ECONNREFUSED => e
  # Caught the connection error we expected
  puts "TC007: PASS — Caught unreachable‑portal error (#{e.class})"
  exit(0)

ensure
  browser&.quit
end
