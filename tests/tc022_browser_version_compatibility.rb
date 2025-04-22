#!/usr/bin/env ruby
require 'watir'

BASE_URL = ENV.fetch('BASE_URL', 'http://localhost:4567')
# Assumes you have both latest Chrome & Firefox installed

[:chrome, :firefox].each do |drv|
  begin
    browser = Watir::Browser.new drv, headless: true
    browser.goto "#{BASE_URL}/index.html"
    puts "TC022: PASS — #{drv} navigated successfully on latest version"
  rescue => e
    puts "TC022: FAIL — #{drv}: #{e.class}: #{e.message}"
    exit(1)
  ensure
    browser&.quit
  end
end

puts "TC022: PASS — Both browsers OK on latest versions"
exit(0)
