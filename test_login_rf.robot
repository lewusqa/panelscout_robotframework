*** Settings ***
Documentation    Suite description
Documentation    This is a sample test case for Robot Framework
Library           SeleniumLibrary

*** Test Cases ***
Login Test
    [Documentation]    Test the login functionality of the website
    Open Browser    https://www.example.com    Chrome
    Maximize Browser Window
    Input Text    id=username    testuser
    Input Text    id=password    testpassword
    Click Button    id=login_button
    Wait Until Page Contains    Welcome, testuser
    Page Should Contain    Logout
    Close Browser

*** Variables ***

 ${LOGIN URL}   https://scouts-test.futbolkolektyw.pl/en
 ${BROWSER}   Chrome
 ${SIGNINBUTTON}   xpath=//*[(text()= 'Sign in')]
 ${EMAILINPUT}   xpath=//*[@id='login']
 ${PASSWORDINPUT}   xpath=//*[@id='password']
 ${PAGELOGO}   xpath=//*[@id='__next']/div[1]/main/div[3]/div[1]/div/div[1]

*** Test Cases ***
Login to the system
#Title of the test
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Assert dashboard
    [Teardown]   Close Browser
#   Provided precondition
#   When action
#   Then check expectations

*** Keywords ***
Open login page
    Open Browser   ${LOGIN URL}   ${BROWSER}
    Title Should Be   Scouts panel - sign in
Type in email
    Input Text   ${EMAILINPUT}   user07@getnada.com
Type in password
    Input Text   ${PASSWORDINPUT}   Test-1234
Click on the Submit button
    Click Element   xpath=//*[(text()= 'Sign in')]
Assert dashboard
    wait until element is visible  ${PAGELOGO}
    title should be   Scouts ponel
    Capture Page Screenshot   alert.png

class TestLoginPage(unittest.TestCase):

    @classmethod
    def setUp(self):
        os.chmod(DRIVER_PATH, 755)
        self.driver_service = Service(executable_path=DRIVER_PATH)
        self.driver = webdriver.Chrome(service=self.driver_service)
        self.driver.get('https://scouts-test.futbolkolektyw.pl/en')
        self.driver.fullscreen_window()
        self.driver.implicitly_wait(IMPLICITLY_WAIT)

    def test_login_page(self):
        user_login = LoginPage(self.driver)
        user_login.title_of_page()
        user_login.check_page_header()
        user_login.type_in_email("user02@getnada.com")
        user_login.type_in_password("Test-1234")
        user_login.wait_for_element_to_be_clickable()
        user_login.click_on_the_sign_in_button()
        dashboard_page = Dashboard(self.driver)
        dashboard_page.title_of_page()

    @classmethod
    def tearDown(self):
        self.driver.quit()