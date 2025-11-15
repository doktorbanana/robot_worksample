*** Settings ***
Documentation       This test suite verifies the filtering functionality of the TodoMVC application.
...                 It includes tests for filtering active and completed items, clearing
...                 completed items while filtered, and ensuring the current filter is
...                 correctly displayed.

Library             Browser
Resource            ../resources/pageobjects/LandingPage.resource
Resource            ../resources/CommonFunctionality.resource

Test Setup          Go To Landing Page


*** Test Cases ***
Test Filtering ToDo Items
    [Documentation]    Tests filtering ToDo items by All, Active, and Completed.
    ...    Expects correct items to be shown for each filter.

    Add ToDo Items    Active Item 1    Active Item 2    Completed Item 1
    Mark ToDo Item As Completed By Text    Completed Item 1

    Check Filter Active Shows Only Items    Active Item 1    Active Item 2
    Check Filter Completed Shows Only Items    Completed Item 1
    Check Filter All Shows Only Items    Active Item 1    Active Item 2    Completed Item 1

Test Clearing Completed Items While Filtered
    [Documentation]    Tests clearing completed ToDo items while filtered to Active.
    ...    Expects only active items to remain after clearing completed items.

    Add ToDo Items    Active Item    Completed Item
    Mark ToDo Item As Completed By Text    Completed Item
    Set Filter To    Active
    Clear Completed ToDo Items
    Set Filter To    All
    Check Number Of ToDo Items    1
    Check List Has Item With Text    Active Item

Test Seeing Current Filter As Selected
    [Documentation]    Tests that the current filter is correctly displayed as selected.
    ...    Expects the selected filter to match the last set filter.

    Add ToDo Item    Item 1

    Set Filter To    All
    ${current_filter}=    Get Current Filter
    Should Be Equal    ${current_filter}    All

    Set Filter To    Active
    ${current_filter}=    Get Current Filter
    Should Be Equal    ${current_filter}    Active

    Set Filter To    Completed
    ${current_filter}=    Get Current Filter
    Should Be Equal    ${current_filter}    Completed


*** Keywords ***
Check Number Of ToDo Items
    [Documentation]    Checks that the number of ToDo items matches the expected count.
    [Arguments]    ${expected_count}
    ${actual_count}=    Get Number Of ToDo Items
    Should Be Equal As Integers    ${actual_count}    ${expected_count}

Check List Has Item With Text
    [Documentation]    Checks that the ToDo list contains an item with the specified text.
    [Arguments]    ${item_text}
    ${item}=    Get Todo Item By Text    ${item_text}
    Should Not Be Equal    ${item}    None

Check Filter ${filter} Shows Only Items
    [Documentation]    Checks that the current filter shows only the expected items.
    [Arguments]    @{expected_items}
    Set Filter To    ${filter}
    ${expected_count}=    Evaluate    len(@{expected_items})
    Check Number Of ToDo Items    ${expected_count}
    FOR    ${item}    IN    @{expected_items}
        Check List Has Item With Text    ${item}
    END
