*** Settings ***
Documentation       A test suite with a single test for valid auth.
Resource            resource.robot

Suite Setup         Init
Suite Teardown      Close All Browsers
Test Setup          Reset And Logout If Necessary

Default Tags        not_logged_in


*** Test Cases ***

Login With Valid Username And Invalid Password
    Topbar Open And Select Popup    Login

    Update Input                    Login       ${VALID USERNAME}
    Update Input                    Password    ${INVALID PASSWORD}

    Submit Form

    Should Not Be Logged In

    Topbar Close Popup


Login With Valid Email And Invalid Password
    Topbar Open And Select Popup    Login

    Update Input                    Login       ${VALID EMAIL}
    Update Input                    Password    ${INVALID PASSWORD}

    Submit Form

    Should Not Be Logged In

    Topbar Close Popup


Login XSRF-Token Changes
    Topbar Open And Select Popup    Login
    
    ${XSRF} =                       Get Input Value     Xsrf
    Topbar Close Popup

    Topbar Open And Select Popup    Login

    ${NEW_XSRF} =                   Get Input Value     Xsrf

    Should Not Be Equal             ${XSRF}             ${NEW_XSRF}

    Topbar Close Popup


Login With Foreign XSRF-Token
    Topbar Open And Select Popup    Login
    
    ${XSRF} =                       Get Input Value     Xsrf

    Reset And Logout If Necessary   True

    Topbar Open And Select Popup    Login

    Update Input                    Xsrf                ${XSRF}
    Update Input                    Login               ${VALID USERNAME}
    Update Input                    Password            ${VALID PASSWORD}

    Submit Form

    Should Not Be Logged In


Valid Login With Username
    Topbar Open And Select Popup    Login

    Update Input                    Login       ${VALID USERNAME}
    Update Input                    Password    ${VALID PASSWORD}

    Submit Form

    Unselect Frame

    Should Be Logged In


Valid Login With Email
    Topbar Open And Select Popup    Login

    Update Input                    Login       ${VALID EMAIL}
    Update Input                    Password    ${VALID PASSWORD}

    Submit Form

    Unselect Frame

    Should Be Logged In


Registration XSRF-Token Changes
    Topbar Open And Select Popup    Registration

    ${XSRF} =                       Get Input Value     Xsrf

    Topbar Close Popup

    Topbar Open And Select Popup    Registration

    ${NEW_XSRF} =                   Get Input Value     Xsrf

    Should Not Be Equal             ${XSRF}             ${NEW_XSRF}

    Topbar Close Popup


Registration With Foreign XSRF-Token
    Topbar Open And Select Popup    Registration
    
    ${XSRF} =                       Get Input Value     Xsrf

    Reset And Logout If Necessary   True

    Topbar Open And Select Popup    Registration

    Update Input                    Xsrf                ${XSRF}
    Update Input                    Email               ${VALID UNREGISTERED EMAIL}
    Update Input                    Login               ${VALID UNREGISTERED USERNAME}
    Update Input                    Password            ${VALID UNREGISTERED PASSWORD}
    Update Input                    Captcha             ${INVALID CAPTCHA}

    Submit Form
    
    Should Open Error Page


Registration Invalid Captcha
    Topbar Open And Select Popup    Registration
    
    Update Input                    Email       ${VALID UNREGISTERED EMAIL}
    Update Input                    Login       ${VALID UNREGISTERED USERNAME}
    Update Input                    Password    ${VALID UNREGISTERED PASSWORD}
    Update Input                    Captcha     ${INVALID CAPTCHA}

    Submit Form

    Should Not Register Successfully

    Topbar Close Popup


Recovery XSRF-Token Changes
    Topbar Open And Select Popup    Login
    Topbar Open And Select Popup    Recovery            False

    ${XSRF} =                       Get Input Value     Xsrf

    Topbar Close Popup

    Topbar Open And Select Popup    Login
    Topbar Open And Select Popup    Recovery            False

    ${NEW_XSRF} =                   Get Input Value     Xsrf

    Should Not Be Equal             ${XSRF}             ${NEW_XSRF}

    Topbar Close Popup


Recovery By Email Invalid Captcha
    Topbar Open And Select Popup    Login
    Topbar Open And Select Popup    Recovery    False

    Update Input                    Email       ${VALID EMAIL}
    Update Input                    Captcha     ${INVALID CAPTCHA}

    Submit Recovery Form

    Should Not Recover Successfully

    Topbar Close Popup


Recovery By Email With Foreign XSRF-Token
    Topbar Open And Select Popup    Login
    Topbar Open And Select Popup    Recovery            False

    ${XSRF} =                       Get Input Value     Xsrf

    Reset And Logout If Necessary   True

    Topbar Open And Select Popup    Login
    Topbar Open And Select Popup    Recovery            False

    Update Input                    Xsrf                ${XSRF}
    Update Input                    Email               ${VALID EMAIL}
    Update Input                    Captcha             ${INVALID CAPTCHA}

    Submit Recovery Form

    Should Open Error Page


Recovery By Username Invalid Captcha
    Topbar Open And Select Popup    Login
    Topbar Open And Select Popup    Recovery        False

    Select By Value                 Recovery Type   username

    Update Input                    Username        ${VALID USERNAME}
    Update Input                    Captcha         ${INVALID CAPTCHA}

    Submit Recovery Form

    Should Not Recover Successfully

    Topbar Close Popup


Recovery By Username With Foreign XSRF-Token
    Topbar Open And Select Popup    Login
    Topbar Open And Select Popup    Recovery            False

    ${XSRF} =                       Get Input Value     Xsrf

    Reset And Logout If Necessary   True

    Topbar Open And Select Popup    Login
    Topbar Open And Select Popup    Recovery            False

    Select By Value                 Recovery Type   username

    Update Input                    Xsrf                ${XSRF}
    Update Input                    Username            ${VALID USERNAME}
    Update Input                    Captcha             ${INVALID CAPTCHA}

    Submit Recovery Form

    Should Open Error Page


Recovery By Phone Number Invalid Captcha
    Topbar Open And Select Popup    Login
    Topbar Open And Select Popup    Recovery        False

    Select By Value                 Recovery Type   phone_number

    Update Input                    Phone Number    ${VALID PHONE NUMBER}
    Update Input                    Captcha         ${INVALID CAPTCHA}

    Submit Recovery Form

    Should Not Recover Successfully

    Topbar Close Popup


Recovery By Phone Number With Foreign XSRF-Token
    Topbar Open And Select Popup    Login
    Topbar Open And Select Popup    Recovery            False

    ${XSRF} =                       Get Input Value     Xsrf

    Reset And Logout If Necessary   True

    Topbar Open And Select Popup    Login
    Topbar Open And Select Popup    Recovery            False

    Select By Value                 Recovery Type   phone_number

    Update Input                    Xsrf                ${XSRF}
    Update Input                    Phone Number        ${VALID PHONE NUMBER}
    Update Input                    Captcha             ${INVALID CAPTCHA}

    Submit Recovery Form

    Should Open Error Page