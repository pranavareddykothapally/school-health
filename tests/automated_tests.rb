# tests/automated_tests.rb
require 'watir'
require 'json'

BASE_URL = 'http://localhost:4567'

# Load test cases from tests/test_cases.json
test_cases_path = File.expand_path('test_cases.json', __dir__)
TEST_CASES = JSON.parse(File.read(test_cases_path))

browser = Watir::Browser.new(:chrome, headless: true)

TEST_CASES.each_with_index do |tc, idx|
  puts "Running E2E Test ##{idx+1}..."
  browser.goto("#{BASE_URL}/index.html")
  browser.link(text: 'Daily Health Form').wait_until(&:present?).click

  # Fill the form
  browser.text_field(id: 'parentName').set(tc['PARENT_NAME'])
  browser.text_field(id: 'parentTZ').set(tc['PARENT_TZ'])
  browser.text_field(id: 'childNames').set(tc['CHILDRENS_NAMES'])
  browser.text_field(id: 'childTZ').set(tc['CHILDRENS_TZ'])
  browser.button(type: 'submit').click

  # Wait for redirect to dashboard
  browser.wait_until(timeout: 5) { |b| b.url.include?('dashboard.html') }
  table = browser.table(class: 'table')
  if table.exists? && table.tbody.trs.any?
    puts "Test ##{idx+1}: PASS"
  else
    puts "Test ##{idx+1}: FAIL"
  end
end

browser.close
