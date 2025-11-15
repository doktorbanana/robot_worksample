# Automated Test Framework for ToDoMVC.com
Professional test automation framework demonstrating best practices for UI testing of web applications. Built with Robot Framework and the Browser library, this project tests the TodoMVC Angular application to showcase expertise in test design, maintainability, and CI/CD integration for Software QA/Test Automation roles.
Key Features

### 🧩 Page Object Model Architecture

- Separation of UI interactions and test logic using resource files
- Common functionality for browser setup and navigation
- Dedicated page object for the landing page with reusable keywords for actions like adding, editing, marking, and removing todo items

## 📦 CI/CD Ready

- GitHub Actions workflow with matrix strategy for Chromium and Firefox
- Automatic result combining using rebot for unified reports
- Deployment of HTML reports and logs to GitHub Pages for easy viewing:
  - See test results here https://doktorbanana.github.io/robot_worksample//report.html
  - See test log here https://doktorbanana.github.io/robot_worksample//log.html
- Artifact uploading for test results, even on failures

## 🌐 Cross-Browser Testing

- Supports Chromium and Firefox via matrix in CI
- Local runs configurable via script parameters
- Can be easily extended

## Technologies Used

- Robot Framework 7
- Browser Library (Playwright-based for headless testing)
- Python 3.13+
- GitHub Actions (CI/CD with matrix testing)
- Robot Framework tools: rebot for report merging, rfbrowser for initialization

## Setup Instructions
### Basic Setup

```bash
git clone https://github.com/yourusername/robot-worksample.git
cd robot-worksample

python -m venv venv
source venv/bin/activate  # Linux/Mac
venv\Scripts\activate     # Windows

pip install -r requirements.txt
rfbrowser init
```
Note: Ensure you have the Browser library installed via requirements.txt. The rfbrowser init command sets up the necessary browsers.

### Running Tests
Run tests locally using the provided script, specifying the browser:
```bash
./scripts/run_tests.sh chromium
```

This executes all tests in the specified browser, generates reports in test_results/<browser>/, and includes HTML reports and logs.

For CI, tests run automatically on push/PR to main via GitHub Actions, covering both Chromium and Firefox, with combined results deployed to GitHub Pages.
