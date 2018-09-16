*** Settings ***
Documentation     A resource file with reusable variables.
Library                             Selenium2Library
Library                             BuiltIn
Library                             custom_simpals_auth.py

*** Variables ***
${HOME URL}                         https://numbers.md/ru/

${BROWSER}                          Chrome
${DELAY}                            0.05

${VALID UNREGISTERED EMAIL}         testtesss112t@ttest.md
${VALID UNREGISTERED USERNAME}      DDD1D1D1D1D1D1D1D1D
${VALID UNREGISTERED PASSWORD}      A1A23123123

${VALID EMAIL}                      alexander.sterpu@gmail.com
${VALID USERNAME}                   alexander-sterpu
${VALID PASSWORD}                   3215987
${VALID PHONE NUMBER}               79644044

${DEFAULT FIRST NAME}               Alexander
${DEFAULT LAST NAME}                Sterpu
${DEFAULT BIRTHDATE DAY}            20
${DEFAULT BIRTHDATE MONTH}          6
${DEFAULT BIRTHDATE YEAR}           1996
${DEFAULT SEX}                      m

${USER2 FIRST NAME}                 Test
${USER2 LAST NAME}                  Атест
${USER2 BIRTHDATE DAY}              15
${USER2 BIRTHDATE MONTH}            3
${USER2 BIRTHDATE YEAR}             1990
${USER2 SEX}                        f

${INVALID USERNAME}                 DDDDDDD
${INVALID PASSWORD}                 123123123
${INVALID CAPTCHA}                  INVVNI

${NEW1 PASSWORD}                    123123123
${NEW2 PASSWORD}                    456456456

${REGISTERED USERNAME}              admin
${REGISTERED EMAIL}                 office@demo.md
