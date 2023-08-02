*** Settings ***
Documentation    Suite description
Library     SeleniumLibrary

*** Variables ***
#${LOGIN URL}        https://scouts-test.futbolkolektyw.pl/en
${LOGIN URL}     https://dareit.futbolkolektyw.pl/en
${BROWSER}      Chrome
${SIGNINBUTTON}     xpath=//*[(text()= 'Sign in')]
${EMAILINPUT}       xpath=//*[@id='login']
${PASSWORDINPUT}        xpath=//*[@id='password']
${PAGELOGO}     xpath=//*[@id='__next']/div[1]/main/div[3]/div[1]/div/div[1]

*** Test Cases ***
Login to the system
#Title of the test
    Open login page
    Type in Email
    Type in password
    Click on the Submit button
    Assert dashboard
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
    Capture Page Screenshot     alert.png
