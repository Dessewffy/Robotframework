*** Settings ***
Library   Selenium2Library

*** Variables ***
#Declare variables and lists. LOGIN-Credentials are in a list.
${LOGIN-BUTTON}   //*[@id="navbar"]/ul/li[2]/a 
@{LOGIN-Credentials-GUEST}   hogap65094@zamaneta.com   1234

*** Test Cases ***
hotel-v3 guest login
    # Maximize the browser because Selenium can't find the ${LOGIN-BUTTON} element in all cases
    Open Browser    http://hotel-v3.progmasters.hu     chrome 
    Maximize Browser Window
    Click Element      ${LOGIN-BUTTON}

    # Perform login.
    Input Text        //*[@id="email"]   ${LOGIN-Credentials-GUEST}[0]
    Input Text        //*[@id="password"]   ${LOGIN-Credentials-GUEST}[1]
    Click Element     //*[@id="loginMember"]/div[3]/div/button
    Capture Page Screenshot
    