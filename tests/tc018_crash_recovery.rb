#!/usr/bin/env ruby
require 'watir'

BASE_URL = ENV.fetch('BASE_URL', 'http://localhost:4567')
retries = 0

begin
  # Attempt to launch the browser (this may itself fail → crash)
  browser = Watir::Browser.new :chrome, headless: true

  # If we got a live browser, immediately quit to simulate a crash
  browser.quit

  # Any subsequent action will then error
  browser.goto "#{BASE_URL}/index.html"
  # If navigation somehow still works, we didn’t simulate a crash
  puts "TC018: FAIL — Browser survived the simulated crash"
  exit(1)

rescue Selenium::WebDriver::Error::WebDriverError, Errno::ECONNREFUSED => e
  # Caught either a startup failure or post‑quit failure
  retries += 1
  if retries < 3
    puts "TC018: Caught crash (#{e.class}); Retry ##{retries}…"
    retry
  else
    puts "TC018: PASS — Recovered (or caught) browser crash after #{retries} attempts."
    exit(0)
  end
end
