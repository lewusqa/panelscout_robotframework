*** Settings ***
Documentation    Suite description
Library     SeleniumLibrary

*** Variables ***
${LOGIN URL}        https://scouts-test.futbolkolektyw.pl/en
${BROWSER}      Chrome
${SIGNINBUTTON}     xpath=//*[(text()= 'Sign in')]
${EMAILINPUT}       xpath=//*[@id='login']
${PASSWORDINPUT}        xpath=//*[@id='password']
${PAGELOGO}     xpath=//*[@id='__next']/div[1]/main/div[3]/div[1]/div/div[1]
${ADDPLAYERNBUTTON}     xpath=//*[text()='Add player']
${WEIGHTINPUT}      xpath=//*[@name='weight']
${HEIGHTINPUT}      xpath=//*[@name='height']
${NAMEINPUT}        xpath=//*[@name='name']
${SURNAMEINPUT}     xpath=//*[@name='surname']
${AGEINPUT}     xpath=//*[@name='age']
${MAINPOSITIONINPUT}        xpath=//input[@name='mainPosition']
${ADDPLAYERLOGO}        xpath=//*[@id="__next"]/div[1]/main/div[2]/form/div[1]/div/span
${SIGNOUT}      xpath=//span[text() = 'Sign out']
#${RIGHTLEG}     xpath=//*[@id='menu-leg']/div[3]/ul/li[1]
#${LEFTLEG}      xpath=//*[@id='menu-leg']/div[3]/ul/li[2]
#${SELECTLEG}    xpath=//*[@id='mui-component-select-leg']
#${CLEARBUTTON}      xpath=//*[@id='__next']/div[1]/main/div[2]/form/div[3]/button[2]/span[1]
#${LISTOFPLAYERS}        xpath=//*[@id='__next']/div[1]/div/div/div/ul[1]/div[2]/div[2]/span
${LISTOFPLAYERSDASHBOARD}       xpath=//*[@id="__next"]/div[1]/main/div[2]/div/div/table/tfoot/tr/td/div/div/div/p

*** Test Cases ***
Login to the system
#Title of the test
    Open login page
    Type in Email
    Type in password
    Click on the Submit button
    Assert dashboard
    Click on the Addplayer button
    Type in Weight
    Type in Height
    CLick on the Clear button
    Type in Name
    Type in Surname
    Type in Age
    Type in Mainposition
    #Type in Leg
    Click on the Save button
    Assert addplayer
    Show list of players
    Assert list of players
    Click on the Sign out button
    Assert if sign out button is not be visible
    [Teardown]   Close Browser
#   Provided precondition
#   When action
#   Then check expectations

*** Keywords ***
Open login page
    Open Browser        ${LOGIN URL}        ${BROWSER}
    Title Should Be     Scouts panel - sign in
Type in email
    Input Text      ${EMAILINPUT}       user07@getnada.com
Type in password
    Input Text      ${PASSWORDINPUT}        Test-1234
Click on the Submit button
    Click Element       xpath=//*[(text()= 'Sign in')]
Assert dashboard
   # wait until element is visible  ${PAGELOGO}
    Wait Until Keyword Succeeds    1 min    1 sec   Wait Until Element Is Visible    ${PAGELOGO}
    Title Should Be     Scouts panel
Click on the Addplayer button
    Click Element       xpath=//*[text()='Add player']
Type in Weight
    Input Text      ${WEIGHTINPUT}       88
Type in Height
    Input Text      ${HEIGHTINPUT}       188
Click on the Clear button
    Click Element       xpath=//*[@id='__next']/div[1]/main/div[2]/form/div[3]/button[2]/span[1]
Type in Name
    Input Text      ${NAMEINPUT}       Adam
Type in Surname
    Input Text      ${SURNAMEINPUT}       Adamski
Type in Age
    Input Text      ${AGEINPUT}       22.07.1988
Type in Mainposition
    Input Text      ${MAINPOSITIONINPUT}       goalkeeper
#Type in Leg
    #Select From List By Value       ${SELECTLEG}
    #Select From List By Value       ${LEFTLEG}
Click on the Save button
    Click Element       xpath=//button[@type='submit']
Assert addplayer
   # wait until element is visible  ${PAGELOGO}
    Wait Until Keyword Succeeds    1 min    3 sec   Wait Until Element Is Visible    ${ADDPLAYERLOGO}
    Title Should Be     Add player
Show list of players
    Click Element       xpath=//*[@id='__next']/div[1]/div/div/div/ul[1]/div[2]/div[2]/span
Assert list of players
     Wait Until Keyword Succeeds    1 min    3 sec   Wait Until Element Is Visible    ${LISTOFPLAYERSDASHBOARD}
     ${LISTOFPLAYERSDASHBOARD}    Get Title
     Should Contain    ${LISTOFPLAYERSDASHBOARD}    Players
Click on the Sign out button
    Click Element       xpath=//span[text() = 'Sign out']
Assert if sign out button is not be visible
    Element Should Not Be Visible       xpath=//span[text() = 'Sign out']
    Capture Page Screenshot     alert.png
