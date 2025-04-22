# Test Suite Overview

This repository contains automated test scripts organized by module and test case ID. Below is a mapping of each test case to its corresponding file.

## 1. Configuration Management
- **TC002**, **TC009**, **TC010**: `frontend/spec/authentication_and_env_spec.rb`
  - Verifies loading of `.env` and handling missing or incomplete configuration.

## 2. User Authentication & Login
- **TC001**, **TC003**, **TC004**, **TC006**, **TC017**: `frontend/spec/login_spec.rb`
  - Tests valid/invalid credentials, navigation to login page, link selection, and multiple link handling.

## 3. Form Navigation & Submission
- **TC005**, **TC020**: `tests/automated_tests.rb`
  - Executes the happy‑path health declaration form submission and repeated submissions behavior.

## 4. Error & Exception Handling
- **TC007**: `tests/tc007_unreachable_portal.rb`  
  Handles unreachable portal URL.
- **TC008**: `tests/tc008_missing_submit.rb`  
  Detects missing submit button element.
- **TC014**: `tests/tc014_server_error.rb`  
  Simulates HTTP 500 on form submission.
- **TC018**: `tests/tc018_crash_recovery.rb`  
  Simulates and recovers from unexpected browser crash.

## 5. Compatibility & Resilience
- **TC009**: `tests/tc009_headless_mode.rb`  
  Validates headless browser support.
- **TC015**: `tests/tc015_screenshot_capture.rb`  
  Verifies screenshot capture on page load.
- **TC019**: `tests/tc019_cross_browser.rb`  
  Checks Chrome & Firefox headless compatibility.
- **TC021**: `tests/tc021_full_headless_e2e.rb`  
  Runs full login + form flow in headless mode.
- **TC022**: `tests/tc022_browser_version_compatibility.rb`  
  Tests compatibility with the latest browser versions.

## Additional Notes
- **Console Logs (TC012)** are integrated into each script—look for `PASS`, `FAIL`, or `WARN` messages in the terminal output.
- **Redirect Handling (TC016)** and **Retry on Slow Elements (TC015)** are covered within the E2E and error‑handling scripts respectively.

---

To run any test, ensure your Sinatra server is running on `http://localhost:4567`, then:
```bash
ruby <path-to-test-script>.rb
```
Each script will exit with code `0` on PASS and `1` on FAIL.

