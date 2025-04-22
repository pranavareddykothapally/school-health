#!/usr/bin/env ruby
require 'watir'
require 'json'

BASE_URL = ENV.fetch('BASE_URL', 'http://localhost:4567')
TEST_CASES = JSON.parse(File.read('tests/test_cases.json'))

# TC021: Full headless end‑to‑end (login + form)
begin
  browser = Watir::Browser.new :chrome, headless: true

  # 1) Login
  browser.goto "#{BASE_URL}/login.html"
  browser.text_field(id: 'user').wait_until(&:present?).set     ENV['USERNAME']
  browser.text_field(id: 'pass').set     ENV['PASSWORD']
  # click button by text since id may not exist
  browser.button(text: 'Sign In').click
  raise "Login failed; current URL: \#{browser.url}" unless browser.url.include?('/dashboard.html')

  # 2) Form submissions
  TEST_CASES.each_with_index do |tc, idx|
    browser.link(text: 'Daily Health Form').wait_until(&:present?).click
    browser.text_field(id: 'parentName').wait_until(&:present?).set(tc['PARENT_NAME'])
    browser.text_field(id: 'parentTZ').set(tc['PARENT_TZ'])
    browser.text_field(id: 'childNames').set(tc['CHILDRENS_NAMES'])
    browser.text_field(id: 'childTZ').set(tc['CHILDRENS_TZ'])
    browser.button(type: 'submit').click
    # confirm redirect
    unless browser.url.include?('dashboard.html')
      raise "Submission \#{idx+1} failed; current URL: \#{browser.url}"
    end
  end

  puts "TC021: PASS — Full headless flow succeeded"
  exit(0)
rescue => e
  puts "TC021: FAIL — \#{e.class}: \#{e.message}"  
  exit(1)
ensure
  browser&.quit
end
