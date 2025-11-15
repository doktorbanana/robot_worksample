*** Settings ***
Documentation     This test suite verifies the basic item management functionality of the TodoMVC application.
...    It includes tests for adding, completing, removing, and editing ToDo items,
...    as well as verifying the displayed count and the visibility of the clear completed button.
Library   Browser
Resource   ../Resources/PageObjects/LandingPage.resource
Resource   ../Resources/CommonFunctionality.resource
Test Setup    Go To Landing Page


*** Test Cases ***
Test Adding ToDo Items
    [Documentation]    Tests adding multiple ToDo items.
    ...    Expects all added items to be in the list.
    Add ToDo Item    Buy groceries
    Add ToDo Item    Walk the dog
    Add ToDo Item    Read a book
    Check Number Of ToDo Items    3
    Check List Has Item With Text    Buy groceries
    Check List Has Item With Text    Walk the dog
    Check List Has Item With Text    Read a book

Test Marking ToDo Item As Completed
    [Documentation]    Tests marking a ToDo item as completed.
    ...    Expects the item to have the 'completed' class.
    Add ToDo Item    Learn Robot Framework
    Mark ToDo Item As Completed By Text    Learn Robot Framework
    Check Item Is Completed By Text    Learn Robot Framework

Test Removing ToDo Items
    [Documentation]    Tests removing a ToDo item.
    ...    Expects the item to be removed from the list.
    Add ToDo Item    Item to be removed
    Check Number Of ToDo Items    1
    Remove ToDo Item By Text    Item to be removed
    Check Number Of ToDo Items    0

Test Edit ToDo Item
    [Documentation]    Tests editing a ToDo item.
    ...    Expects the item text to be updated in the list.
    Add ToDo Item    Old Item Text
    Edit ToDo Item By Text    Old Item Text    New Item Text
    Check List Has Item With Text    New Item Text

Test Seeing Clear Completed Button
    [Documentation]    Tests the visibility of the Clear Completed button.
    ...    Expects the button to be visible only when there are completed items.
    Add ToDo Item    Active Item
    Add ToDo Item    Completed Item
    Mark ToDo Item As Completed By Text    Completed Item
    ${is_visible}=    Clear Completed Button Is Visible
    Should Be True    ${is_visible}
    Clear Completed ToDo Items
    ${is_visible}=    Clear Completed Button Is Visible
    Should Not Be True    ${is_visible}

Test Removing Completed ToDo Items
    [Documentation]    Tests removing completed ToDo items.
    ...    Expects only active items to remain after clearing completed items.
    Add ToDo Item    Active Item
    Add ToDo Item    Completed Item
    Mark ToDo Item As Completed By Text    Completed Item
    Check Number Of ToDo Items    2
    Clear Completed ToDo Items
    Check Number Of ToDo Items    1
    Check List Has Item With Text    Active Item

Test Count Displayed Matches Actual Count
    [Documentation]    Tests that the displayed ToDo count matches the actual number of items.
    ...    Expects the count to update correctly after adding and removing items.
    Add ToDo Item    Task 1
    Add ToDo Item    Task 2
    Add ToDo Item    Task 3
    ${displayed_count}=    Get Displayed Todo Count
    Should Be Equal As Integers    ${displayed_count}    3
    Remove ToDo Item By Text    Task 2
    ${displayed_count}=    Get Displayed Todo Count
    Should Be Equal As Integers    ${displayed_count}    2


*** Keywords ***
Check Number Of ToDo Items
    [Documentation]    Checks that the number of ToDo items matches the expected count.
    [Arguments]    ${expected_count}
    ${actual_count}=    Get Number Of ToDo Items
    Should Be Equal As Integers    ${actual_count}    ${expected_count}

Check Item Is Completed By Text
    [Documentation]    Checks that the ToDo item with the specified text has the 'completed' class.
    [Arguments]    ${item_text}
    @{classes}=    Get Todo Item Classes By Text    ${item_text}
    Should Contain    @{classes}    completed

Check List Has Item With Text
    [Documentation]    Checks that the ToDo list contains an item with the specified text.
    [Arguments]    ${item_text}
    ${item}=    Get Todo Item By Text    ${item_text}
    Should Not Be Equal    ${item}    None
