*** Settings ***
Library   Browser
Resource   ../Resources/PageObjects/LandingPage.robot
Resource   ../Resources/CommonFunctionality.robot
Test Setup    Go To Landing Page

*** Test Cases ***
Test Filtering Items
    Add ToDo Item    Active Item 1
    Add ToDo Item    Active Item 2
    Add ToDo Item    Completed Item 1
    Mark ToDo Item As Completed By Text    Completed Item 1
    
    Set Filter To    Active
    Check Number Of ToDo Items    2
    Check List Has Item With Text    Active Item 1
    Check List Has Item With Text    Active Item 2
    
    Set Filter To    Completed
    Check Number Of ToDo Items    1
    Check List Has Item With Text    Completed Item 1
    
    Set Filter To    All
    Check Number Of ToDo Items    3
    Check List Has Item With Text    Active Item 1
    Check List Has Item With Text    Active Item 2
    Check List Has Item With Text    Completed Item 1

Test Clearing Completed Items While Filtered
    Add ToDo Item    Active Item
    Add ToDo Item    Completed Item
    Mark ToDo Item As Completed By Text    Completed Item
    Set Filter To    Active
    Clear Completed ToDo Items
    Set Filter To    All
    Check Number Of ToDo Items    1
    Check List Has Item With Text    Active Item

Test Seeing Current Filter As Selected
    Add ToDo Item    Item 1
    
    Set Filter To    All
    ${current_filter}=    Get Current Filter
    Should Be Equal    ${current_filter}    All
    
    Set Filter To    Active
    ${current_filter}=    Get Current Filter
    Should Be Equal   ${current_filter}    Active
    
    Set Filter To    Completed
    ${current_filter}=    Get Current Filter
    Should Be Equal    ${current_filter}    Completed

*** Keywords ***
Check Number Of ToDo Items    [Arguments]    ${expected_count}
    ${actual_count}=    Get Number Of ToDo Items
    Should Be Equal As Integers    ${actual_count}    ${expected_count}

Check List Has Item With Text    [Arguments]    ${item_text}
    ${item}=    Get Todo Item By Text    ${item_text}
    Should Not Be Equal    ${item}    None