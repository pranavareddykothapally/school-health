#!/usr/bin/env ruby
require 'watir'

BASE_URL = ENV.fetch('BASE_URL', 'http://localhost:4567')

# TC009: Headless‑mode support
begin
  browser = Watir::Browser.new :chrome, headless: true
  browser.goto "#{BASE_URL}/login.html"
  puts "TC009: PASS — Headless Chrome launched and navigated"
  exit(0)
rescue => e
  puts "TC009: FAIL — #{e.class}: #{e.message}"
  exit(1)
ensure
  browser&.quit
end
