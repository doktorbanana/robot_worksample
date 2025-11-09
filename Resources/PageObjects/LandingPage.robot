*** Settings ***
Library   Browser
Resource   ../../Resources/CommonFunctionality.robot

*** Keywords ***
Add ToDo Item    [Arguments]    ${item_text}
    Fill Text    input.new-todo    ${item_text}
    Press Keys    input.new-todo    Enter

Get Number Of ToDo Items
    ${count}=    Get Element Count    ul.todo-list li
    RETURN    ${count}

Get Displayed Todo Count
    ${count_element}=    Get Element    span.todo-count strong
    ${count_text}=    Get Text    ${count_element}
    RETURN    ${count_text}

Get Todo List
    @{items}=    Get Elements    ul.todo-list li
    RETURN    @{items}

Get Todo Item By Text    [Arguments]    ${item_text}
    @{list}=    Get Todo List
    FOR    ${item}    IN    @{list}
        ${text}=    Get Text    ${item}
        IF    '${text}' == '${item_text}'
            RETURN    ${item}
        END
    END
    Fail    ToDo item with text '${item_text}' not found.

Mark ToDo Item As Completed By Text    [Arguments]    ${item_text}
    ${item}=    Get Todo Item By Text    ${item_text}
    ${checkbox}=    Get Element    ${item} >> div.view > input.toggle
    Check Checkbox    ${checkbox}

Get Todo Item Classes By Text    [Arguments]    ${item_text}
    ${item}=    Get Todo Item By Text    ${item_text}
    @{class}=    Get Classes    ${item}
    RETURN    @{class}

Remove ToDo Item By Text    [Arguments]    ${item_text}
    ${item}=    Get Todo Item By Text    ${item_text}
    Hover    ${item}
    ${delete_button}=    Get Element    ${item} >> button.destroy
    Click    ${delete_button}

Clear Completed ToDo Items
    Click    button.clear-completed

Clear Completed Button Is Visible
    TRY
        Get Element   button.clear-completed
        RETURN    True
    EXCEPT
        RETURN    False
    END

Edit ToDo Item By Text    [Arguments]    ${old_text}    ${new_text}
    ${item}=    Get Todo Item By Text    ${old_text}
    Click With Options   ${item} >> div.view > label    clickCount=2
    ${edit_input}=    Get Element    ${item} >> input.edit
    Clear Text    ${edit_input}
    Fill Text    ${edit_input}    ${new_text}
    Press Keys    ${edit_input}    Enter

Set Filter To    [Arguments]    ${filter_name: literal["All", "Active", "Completed"]}
    ${filter_element}=    Get Element    ul.filters >> li >> a:has-text("${filter_name}")
    Click    ${filter_element}

Get Current Filter
    ${selected_filter}=    Get Element    ul.filters >> li >> a.selected
    ${filter_text}=    Get Text    ${selected_filter}
    RETURN    ${filter_text}