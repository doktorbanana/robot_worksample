*** Settings ***
Library   Browser
Resource   ../Resources/PageObjects/LandingPage.robot
Resource   ../Resources/CommonFunctionality.robot
Test Setup    Go To Landing Page

*** Test Cases ***
Test Adding ToDo Items
    Add ToDo Item    Buy groceries
    Add ToDo Item    Walk the dog
    Add ToDo Item    Read a book
    Check Number Of ToDo Items    3
    Check List Has Item With Text    Buy groceries
    Check List Has Item With Text    Walk the dog
    Check List Has Item With Text    Read a book

Test Marking ToDo Item As Completed
    Add ToDo Item    Learn Robot Framework
    Mark ToDo Item As Completed By Text    Learn Robot Framework
    Check Item Is Completed By Text    Learn Robot Framework

Test Removing ToDo Items
    Add ToDo Item    Item to be removed
    Check Number Of ToDo Items    1
    Remove ToDo Item By Text    Item to be removed
    Check Number Of ToDo Items    0

Test Edit ToDo Item
    Add ToDo Item    Old Item Text
    Edit ToDo Item By Text    Old Item Text    New Item Text
    Check List Has Item With Text    New Item Text

Test Seeing Clear Completed Button
    Add ToDo Item    Active Item
    Add ToDo Item    Completed Item
    Mark ToDo Item As Completed By Text    Completed Item
    ${is_visible}=    Clear Completed Button Is Visible
    Should Be True    ${is_visible}
    Clear Completed ToDo Items
    ${is_visible}=    Clear Completed Button Is Visible
    Should Not Be True    ${is_visible}

Test Removing Completed ToDo Items
    Add ToDo Item    Active Item
    Add ToDo Item    Completed Item
    Mark ToDo Item As Completed By Text    Completed Item
    Check Number Of ToDo Items    2
    Clear Completed ToDo Items
    Check Number Of ToDo Items    1
    Check List Has Item With Text    Active Item

Test Count Displayed Matches Actual Count
    Add ToDo Item    Task 1
    Add ToDo Item    Task 2
    Add ToDo Item    Task 3
    ${displayed_count}=    Get Displayed Todo Count
    Should Be Equal As Integers    ${displayed_count}    3
    Remove ToDo Item By Text    Task 2
    ${displayed_count}=    Get Displayed Todo Count
    Should Be Equal As Integers    ${displayed_count}    2

*** Keywords ***
Check Number Of ToDo Items    [Arguments]    ${expected_count}
    ${actual_count}=    Get Number Of ToDo Items
    Should Be Equal As Integers    ${actual_count}    ${expected_count}

Check Item Is Completed By Text    [Arguments]    ${item_text}
    @{classes}=    Get Todo Item Classes By Text    ${item_text}
    Should Contain    @{classes}    completed

Check List Has Item With Text    [Arguments]    ${item_text}
    ${item}=    Get Todo Item By Text    ${item_text}
    Should Not Be Equal    ${item}    None