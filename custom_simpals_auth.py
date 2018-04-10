from robot.libraries.BuiltIn import BuiltIn
from selenium.common.exceptions import StaleElementReferenceException, ElementNotInteractableException


block_locators = {
    'topbar panel frame': 'id=topbar-panel',

    'Login frame opener': 'id=user-login-btn',
    'Registration frame opener': 'id=user-register-btn',
    'Recovery frame opener': 'xpath=/html/body/div/div/div[1]/form/footer/button[2]',
    'Settings frame opener': 'xpath=//button[contains(@class,"user-item-btn-settings")]',
    'Notifications frame opener': 'xpath=//button[contains(@class,"user-item-btn-notifications")]',
    
    'Username frame opener': 'id=user-username-btn',
    'Logout frame opener': 'xpath=//*[@id="simpalsid-user"]/ul/li[5]/ul/li[5]/button',

    'Topbar Popup frame': 'id=topbar-popup',
    'Topbar Popup frame close button': 'xpath=//div[@class="popup-close"]',
    'Settings frame': 'id=topbar-settings',
    'Notifications frame': 'topbar-notifications',

    'registration success message': 'xpath=//*[@class="popup-register-body-success"]',

    'recovery form': 'xpath=//form[2]',
    'recovery success message': 'xpath=//*[@class="popup-recovery__body__sent"]',

    'settings success message': 'id=simpalsid-settings-tab-success'
}

input_locators = {
    'Xsrf': 'name=_xsrf',
    'Email': 'name=email',
    'Login': 'name=login',
    'Phone Number': 'name=phone_number',
    'Username': 'name=username',
    'Password': 'name=password',
    'Captcha': 'name=captcha',
    'First Name': 'name=first_name',
    'Last Name': 'name=last_name',
    'New Password': 'name=new_password',
    'New Password Repeat': 'name=new_password_repeat'
    
}

select_locators = {
    'Recovery Type': 'xpath=//select[@name="recovery_type"]',
    'Birthdate Day': 'name=birthdate_day',
    'Birthdate Month': 'name=birthdate_month',
    'Birthdate Year': 'name=birthdate_year',
    'Sex': 'name=sex',
}

seleniumlib = BuiltIn().get_library_instance('Selenium2Library')


def init():
    seleniumlib.open_browser(BuiltIn().get_variable_value('${HOME URL}'), BuiltIn().get_variable_value('${BROWSER}'))
    seleniumlib.maximize_browser_window()
    seleniumlib.set_selenium_speed(BuiltIn().get_variable_value('${DELAY}'))


def reset_and_logout_if_necessary(force = False):
    if force or ('auth' in seleniumlib.get_cookies()) or (seleniumlib.get_location() != BuiltIn().get_variable_value('${HOME URL}')):
        seleniumlib.close_all_browsers()
        init()
    else:
        try:
            seleniumlib.wait_until_page_contains_element(block_locators['topbar panel frame'], 1)
        except (Exception):
            seleniumlib.go_to(BuiltIn().get_variable_value('${HOME URL}'))


def init_and_login():
    init()
    
    topbar_open_and_select_popup('Login')
    update_input('Login', BuiltIn().get_variable_value('${VALID USERNAME}'))
    update_input('Password', BuiltIn().get_variable_value('${VALID PASSWORD}'))
    seleniumlib.submit_form()
    seleniumlib.unselect_frame()
    BuiltIn().sleep('100ms')
    should_be_logged_in()


def reset_and_login_if_necessary(force = False):
    if force or ('auth' not in seleniumlib.get_cookies()) or (seleniumlib.get_location() != BuiltIn().get_variable_value('${HOME URL}')):
        seleniumlib.close_all_browsers()
        init_and_login()
    else:
        try:
            seleniumlib.wait_until_page_contains_element(block_locators['topbar panel frame'])
        except (Exception):
            seleniumlib.go_to(BuiltIn().get_variable_value('${HOME URL}'))


def select_topbar():
    seleniumlib.wait_until_page_contains_element(block_locators['topbar panel frame'])
    seleniumlib.select_frame(block_locators['topbar panel frame'])


def topbar_click(name):
    BuiltIn().sleep('100ms')
    seleniumlib.wait_until_page_contains_element(block_locators[name + ' frame opener'])
    seleniumlib.click_element(block_locators[name + ' frame opener'])


def topbar_hover(name):
    seleniumlib.mouse_over(block_locators[name + ' frame opener']) 


def topbar_select_frame(name):
    #seleniumlib.unselect_frame()
    #BuiltIn().sleep('100ms')
    seleniumlib.wait_until_page_contains_element(block_locators[name + ' frame'])
    seleniumlib.select_frame(block_locators[name + ' frame'])


def topbar_open_and_select_popup(name, dont_select_panel = False):
    if not dont_select_panel:
        select_topbar()

    topbar_click(name)
    seleniumlib.unselect_frame()
    topbar_select_frame('Topbar Popup')


def topbar_open_and_select_frame(name, dont_select_panel = False):
    if not dont_select_panel:
        select_topbar()

    topbar_click(name)
    seleniumlib.unselect_frame()
    topbar_select_frame(name)


def topbar_close_popup():
    #BuiltIn().sleep('100ms')
    seleniumlib.page_should_contain_element(block_locators['Topbar Popup frame close button'], 'Close button not found')
    seleniumlib.click_element(block_locators['Topbar Popup frame close button'])
    #seleniumlib.unselect_frame()
    #BuiltIn().sleep('200ms')

    seleniumlib.wait_until_page_does_not_contain_element(block_locators['Topbar Popup frame close button'], 1, 'Close button is here!')


def select_by_value(name, value):
    seleniumlib.select_from_list_by_value(select_locators[name], value)


def get_input_value(name):
    return seleniumlib.get_value(input_locators[name])


def update_input(name, value = ''):
    seleniumlib.wait_until_page_contains_element(input_locators[name])
    seleniumlib.execute_javascript('document.getElementsByName("' + input_locators[name] + '".replace("name=", ""))[0].setAttribute("value", "' + value + '")')


def settings_open_tab(no):
    try:
        seleniumlib.click_element('xpath=//*[@id="pjax-container"]/aside/ul/li[' + no + ']/a')
    except (StaleElementReferenceException):
        seleniumlib.click_element('xpath=//*[@id="pjax-container"]/aside/ul/li[' + no + ']/a')

    seleniumlib.unselect_frame()
    topbar_select_frame('Settings')


def submit_recovery_form():
    seleniumlib.submit_form(block_locators['recovery form'])


def select_value_should_be(name, value):
    seleniumlib.list_selection_should_be(select_locators[name], value)


def input_value_should_be(name, value):
    seleniumlib.textfield_value_should_be(input_locators[name], value)


def should_not_be_logged_in():
    if 'auth' in seleniumlib.get_cookies():
        BuiltIn().sleep('200ms')
        if 'auth' in seleniumlib.get_cookies():
            raise AssertionError("Should not be logged in")


def should_be_logged_in():
    try:
        seleniumlib.get_cookie_value('auth')
    except (Exception):
        BuiltIn().sleep('100ms')
        seleniumlib.get_cookie_value('auth')


def should_open_error_page():
    BuiltIn().sleep('100ms')
    if ('Error' not in seleniumlib.execute_javascript('return document.title;')):
        raise AssertionError("Should open error page")


def should_not_register_successfully():
    seleniumlib.page_should_not_contain_element(block_locators['registration success message'], 'Should not register successfully')

def should_not_recover_successfully():
    seleniumlib.page_should_not_contain_element(block_locators['recovery success message'], 'Should not recover successfully')

def should_not_save_successfully():
    seleniumlib.page_should_not_contain_element(block_locators['settings success message'], 'Should not save successfully')

def should_save_successfully():
    seleniumlib.wait_until_page_contains_element(block_locators['settings success message'])
    seleniumlib.page_should_contain_element(block_locators['settings success message'], 'Should save successfully')