*** Settings ***
Documentation       A test suite with a single test for DEFAULT auth.
Resource            resource.robot

Suite Setup         Init And Login
Suite Teardown      Close All Browsers
Test Setup          Reset And Login If Necessary

Default Tags        logged_in


*** Test Cases ***


Settings General Tab XSRF-Token Changes
    Topbar Open And Select Frame    Settings

    ${XSRF} =                       Get Input Value     Xsrf
    
    Settings Open Tab               1
    ${NEW_XSRF} =                   Get Input Value     Xsrf
    Should Not Be Equal             ${XSRF}             ${NEW_XSRF}
    Unselect Frame

    Select Topbar
    Topbar Click                    Settings
    Unselect Frame


Settings General Tab Foreign XSRF-Token
    Topbar Open And Select Frame    Settings

    ${XSRF} =                       Get Input Value     Xsrf
    Reset And Login If Necessary    True

    Topbar Open And Select Frame    Settings

    Update Input                    Xsrf                ${XSRF}
    Update Input                    First Name          ${USER2 FIRST NAME}
    Update Input                    Last Name           ${USER2 LAST NAME}
    Select By Value                 Birthdate Day       ${USER2 BIRTHDATE DAY}
    Select By Value                 Birthdate Month     ${USER2 BIRTHDATE MONTH}
    Select By Value                 Birthdate Year      ${USER2 BIRTHDATE YEAR}
    Select By Value                 Sex                 ${USER2 SEX}
    Submit Form

    Settings Open Tab               1
    Input Value Should Be           First Name          ${DEFAULT FIRST NAME}
    Input Value Should Be           Last Name           ${DEFAULT LAST NAME}
    Select Value Should Be          Birthdate Day       ${DEFAULT BIRTHDATE DAY}
    Select Value Should Be          Birthdate Month     ${DEFAULT BIRTHDATE MONTH}
    Select Value Should Be          Birthdate Year      ${DEFAULT BIRTHDATE YEAR}
    Select Value Should Be          Sex                 ${DEFAULT SEX}
    Unselect Frame
    
    Select Topbar
    Topbar Click                    Settings
    Unselect Frame


Settings General Tab Details Updates
    Topbar Open And Select Frame    Settings
    
    Update Input                    First Name          ${USER2 FIRST NAME}
    Update Input                    Last Name           ${USER2 LAST NAME}
    Select By Value                 Birthdate Day       ${USER2 BIRTHDATE DAY}
    Select By Value                 Birthdate Month     ${USER2 BIRTHDATE MONTH}
    Select By Value                 Birthdate Year      ${USER2 BIRTHDATE YEAR}
    Select By Value                 Sex                 ${USER2 SEX}
    Submit Form

    Settings Open Tab               1
    Input Value Should Be           First Name          ${USER2 FIRST NAME}
    Input Value Should Be           Last Name           ${USER2 LAST NAME}
    Select Value Should Be          Birthdate Day       ${USER2 BIRTHDATE DAY}
    Select Value Should Be          Birthdate Month     ${USER2 BIRTHDATE MONTH}
    Select Value Should Be          Birthdate Year      ${USER2 BIRTHDATE YEAR}
    Select Value Should Be          Sex                 ${USER2 SEX}

    Update Input                    First Name          ${DEFAULT FIRST NAME}
    Update Input                    Last Name           ${DEFAULT LAST NAME}
    Select By Value                 Birthdate Day       ${DEFAULT BIRTHDATE DAY}
    Select By Value                 Birthdate Month     ${DEFAULT BIRTHDATE MONTH}
    Select By Value                 Birthdate Year      ${DEFAULT BIRTHDATE YEAR}
    Select By Value                 Sex                 ${DEFAULT SEX}
    Submit Form
    Unselect Frame
    
    Select Topbar
    Topbar Click                    Settings
    Unselect Frame


Settings Update Email With Incorrect Password
    Topbar Open And Select Frame    Settings
    Settings Open Tab               2
    
    Update Input                    Email                   ${VALID UNREGISTERED EMAIL}
    Update Input                    Password                ${INVALID PASSWORD}
    Submit Form

    Should Not Save Successfully
    Unselect Frame
    
    Select Topbar
    Topbar Click                    Settings
    Unselect Frame


Settings Update Email With Empty New Email
    Topbar Open And Select Frame    Settings
    Settings Open Tab               2
    
    Update Input                    Password                ${VALID PASSWORD}
    Submit Form

    Should Not Save Successfully
    Unselect Frame
    
    Select Topbar
    Topbar Click                    Settings
    Unselect Frame


Settings Update Email With Non-Unique New Email
    Topbar Open And Select Frame    Settings
    Settings Open Tab               2
    
    Update Input                    Email                   ${REGISTERED EMAIL}
    Update Input                    Password                ${VALID PASSWORD}
    Submit Form

    Should Not Save Successfully
    Unselect Frame
    
    Select Topbar
    Topbar Click                    Settings
    Unselect Frame


Settings Email Form Submits
    Topbar Open And Select Frame    Settings
    Settings Open Tab               2
    
    Update Input                    Email                   ${VALID UNREGISTERED EMAIL}
    Update Input                    Password                ${VALID PASSWORD}
    Submit Form

    Should Save Successfully
    Unselect Frame
    
    Select Topbar
    Topbar Click                    Settings
    Unselect Frame


Settings Update Password With Empty New Password
    Topbar Open And Select Frame    Settings
    Settings Open Tab               5
    
    Update Input                    Password                ${VALID PASSWORD}
    Submit Form

    Should Not Save Successfully
    Unselect Frame
    
    Select Topbar
    Topbar Click                    Settings
    Unselect Frame


Settings Update Password With Incorrect Repeated Password
    Topbar Open And Select Frame    Settings
    Settings Open Tab               5
    
    Update Input                    New Password            ${NEW1 PASSWORD}
    Update Input                    New Password Repeat     ${NEW2 PASSWORD}
    Update Input                    Password                ${VALID PASSWORD}
    Submit Form

    Should Not Save Successfully
    Unselect Frame
    
    Select Topbar
    Topbar Click                    Settings
    Unselect Frame


Settings Update Password With Incorrect Current Password
    Topbar Open And Select Frame    Settings
    Settings Open Tab               5
    
    Update Input                    New Password            ${NEW1 PASSWORD}
    Update Input                    New Password Repeat     ${NEW1 PASSWORD}
    Update Input                    Password                ${INVALID PASSWORD}
    Submit Form

    Should Not Save Successfully
    Unselect Frame
    
    Select Topbar
    Topbar Click                    Settings
    Unselect Frame


Settings Password Updates
    Topbar Open And Select Frame    Settings
    Settings Open Tab               5
    
    Update Input                    New Password            ${NEW1 PASSWORD}
    Update Input                    New Password Repeat     ${NEW1 PASSWORD}
    Update Input                    Password                ${VALID PASSWORD}
    Submit Form

    Settings Open Tab               5
    Update Input                    New Password            ${VALID PASSWORD}
    Update Input                    New Password Repeat     ${VALID PASSWORD}
    Update Input                    Password                ${NEW1 PASSWORD}
    Submit Form
    Unselect Frame
    
    Select Topbar
    Topbar Click                    Settings
    Unselect Frame


Settings Update Username With Incorrect Password
    Topbar Open And Select Frame    Settings
    Settings Open Tab               6
    
    Update Input                    Login                   ${VALID UNREGISTERED USERNAME}
    Update Input                    Password                ${INVALID PASSWORD}
    Submit Form

    Should Not Save Successfully
    Unselect Frame
    
    Select Topbar
    Topbar Click                    Settings
    Unselect Frame


Settings Update Username With Empty New Username
    Topbar Open And Select Frame    Settings
    Settings Open Tab               6
    
    Update Input                    Password                ${VALID PASSWORD}
    Submit Form

    Should Not Save Successfully
    Unselect Frame
    
    Select Topbar
    Topbar Click                    Settings
    Unselect Frame


Settings Update Username With Non-Unique Username
    Topbar Open And Select Frame    Settings
    Settings Open Tab               6
    
    Update Input                    Login                   ${REGISTERED USERNAME}
    Update Input                    Password                ${VALID PASSWORD}
    Submit Form

    Should Not Save Successfully
    Unselect Frame
    
    Select Topbar
    Topbar Click                    Settings
    Unselect Frame


Settings Username Updates
    Topbar Open And Select Frame    Settings
    Settings Open Tab               6
    
    Update Input                    Login                   ${VALID UNREGISTERED USERNAME}
    Update Input                    Password                ${VALID PASSWORD}
    Submit Form
    Should Save Successfully

    Settings Open Tab               6
    Update Input                    Login                   ${VALID USERNAME}
    Update Input                    Password                ${VALID PASSWORD}
    Submit Form
    Page Should Contain             ${VALID USERNAME}
    Unselect Frame
    
    Select Topbar
    Topbar Click                    Settings
    Unselect Frame

Logout
    Select Topbar
    Topbar Hover        Username
    Topbar Hover        Logout
    Topbar Click        Logout
    Unselect Frame

    Should Not Be Logged In
