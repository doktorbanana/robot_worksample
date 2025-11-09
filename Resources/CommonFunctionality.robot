*** Settings ***
Library   Browser

*** Variables ***
${LANDING_PAGE_URL}    https://todomvc.com/examples/angular/dist/browser/#/all
${BROWSER}    chromium
${HEADLESS}    True

*** Keywords ***
Go To Landing Page
    New Browser    ${BROWSER}    headless=${HEADLESS}
    New Page    https://todomvc.com/examples/angular/dist/browser/#/all
    Get Title    should be    TodoMVC: Angular
 