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
${NAMEINPUT}        xpath=//*[@name='name']
${SURNAMEINPUT}     xpath=//*[@name='surname']
${AGEINPUT}     xpath=//*[@name='age']
${MAINPOSITIONINPUT}        xpath=//input[@name='mainPosition']
${ADDPLAYERLOGO}        xpath=//*[@id="__next"]/div[1]/main/div[2]/form/div[1]/div/span
*** Test Cases ***
Login to the system
#Title of the test
    Open login page
    Type in Email
    Type in password
    Click on the Submit button
    Assert dashboard
    Click on the Addplayer button
    Type in Name
    Type in Surname
    Type in Age
    Type in Mainposition
    Click on the Save button
    Assert addplayer
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
Type in Name
    Input Text      ${NAMEINPUT}       Adam
Type in Surname
    Input Text      ${SURNAMEINPUT}       Adamski
Type in Age
    Input Text      ${AGEINPUT}       22.07.1988
Type in Mainposition
    Input Text      ${MAINPOSITIONINPUT}       goalkeeper
Click on the Save button
    Click Element       xpath=//button[@type='submit']
Assert addplayer
   # wait until element is visible  ${PAGELOGO}
    Wait Until Keyword Succeeds    1 min    1 sec   Wait Until Element Is Visible    ${ADDPLAYERLOGO}
    Title Should Be     Add player
    Capture Page Screenshot     alert.png
