*** Settings ***
Documentation       This Page Object represents the Landing Page of the TodoMVC application.
...                 It provides keywords to interact with and verify elements on the page.

Library             Browser
Resource            ../../Resources/CommonFunctionality.resource


*** Keywords ***
Add ToDo Item
    [Documentation]    Adds a new ToDo item with the specified text.
    [Arguments]    ${item_text}
    Fill Text    input.new-todo    ${item_text}
    Press Keys    input.new-todo    Enter

Get Number Of ToDo Items
    [Documentation]    Returns the number of ToDo items currently in the list.
    ${count}=    Get Element Count    ul.todo-list li
    RETURN    ${count}

Get Displayed Todo Count
    [Documentation]    Returns the number displayed in the todo count element.
    ${count_element}=    Get Element    span.todo-count strong
    ${count_text}=    Get Text    ${count_element}
    RETURN    ${count_text}

Get Todo List
    [Documentation]    Returns a list of all ToDo item elements.
    @{items}=    Get Elements    ul.todo-list li
    RETURN    @{items}

Get Todo Item By Text
    [Documentation]    Returns the ToDo item element that matches the specified text.
    [Arguments]    ${item_text}
    @{list}=    Get Todo List
    FOR    ${item}    IN    @{list}
        ${text}=    Get Text    ${item}
        IF    '${text}' == '${item_text}'    RETURN    ${item}
    END
    Fail    ToDo item with text '${item_text}' not found.

Mark ToDo Item As Completed By Text
    [Documentation]    Marks the ToDo item with the specified text as completed.
    [Arguments]    ${item_text}
    ${item}=    Get Todo Item By Text    ${item_text}
    ${checkbox}=    Get Element    ${item} >> div.view > input.toggle
    Check Checkbox    ${checkbox}

Get Todo Item Classes By Text
    [Documentation]    Returns the list of CSS classes for the ToDo item with the specified text.
    [Arguments]    ${item_text}
    ${item}=    Get Todo Item By Text    ${item_text}
    @{class}=    Get Classes    ${item}
    RETURN    @{class}

Remove ToDo Item By Text
    [Documentation]    Removes the ToDo item with the specified text from the list.
    [Arguments]    ${item_text}
    ${item}=    Get Todo Item By Text    ${item_text}
    Hover    ${item}
    ${delete_button}=    Get Element    ${item} >> button.destroy
    Click    ${delete_button}

Clear Completed ToDo Items
    [Documentation]    Clears all completed ToDo items from the list.
    Click    button.clear-completed

Clear Completed Button Is Visible
    [Documentation]    Returns True if the Clear Completed button is visible, False otherwise.
    TRY
        Get Element    button.clear-completed
        RETURN    True
    EXCEPT
        RETURN    False
    END

Edit ToDo Item By Text
    [Documentation]    Edits the ToDo item with the specified old text to have the new text.
    [Arguments]    ${old_text}    ${new_text}
    ${item}=    Get Todo Item By Text    ${old_text}
    Click With Options    ${item} >> div.view > label    clickCount=2
    ${edit_input}=    Get Element    ${item} >> input.edit
    Clear Text    ${edit_input}
    Fill Text    ${edit_input}    ${new_text}
    Press Keys    ${edit_input}    Enter

Set Filter To
    [Documentation]    Sets the current filter to All, Active, or Completed.
    [Arguments]    ${filter_name: literal["All", "Active", "Completed"]}
    ${filter_element}=    Get Element    ul.filters >> li >> a:has-text("${filter_name}")
    Click    ${filter_element}

Get Current Filter
    [Documentation]    Returns the name of the currently selected filter: All, Active, or Completed.
    ${selected_filter}=    Get Element    ul.filters >> li >> a.selected
    ${filter_text}=    Get Text    ${selected_filter}
    RETURN    ${filter_text}
