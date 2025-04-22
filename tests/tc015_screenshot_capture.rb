#!/usr/bin/env ruby
require 'watir'
require 'fileutils'

BASE_URL = ENV.fetch('BASE_URL', 'http://localhost:4567')
FileUtils.mkdir_p('tmp')

# TC015: Screenshot on page load
begin
  browser = Watir::Browser.new :chrome, headless: true
  browser.goto "#{BASE_URL}/login.html"
  path = "tmp/login_page.png"
  browser.screenshot.save(path)
  if File.exist?(path)
    puts "TC015: PASS — Screenshot saved to #{path}"
    exit(0)
  else
    puts "TC015: FAIL — Screenshot not found"
    exit(1)
  end
rescue => e
  puts "TC015: FAIL — #{e.class}: #{e.message}"
  exit(1)
ensure
  browser&.quit
end
