*** Settings ***
Documentation     This Resource file contains common functionality shared across multiple Page Objects.
...    It includes keywords for navigating to the landing page of the TodoMVC application.
Library   Browser


*** Variables ***
${LANDING_PAGE_URL}    https://todomvc.com/examples/angular/dist/browser/#/all
${BROWSER}    chromium
${HEADLESS}    True


*** Keywords ***
Go To Landing Page
    [Documentation]    Opens the TodoMVC landing page in a new browser page.
    New Browser    ${BROWSER}    headless=${HEADLESS}
    New Page    https://todomvc.com/examples/angular/dist/browser/#/all
    Get Title    should be    TodoMVC: Angular
