*** Settings ***
# Use Selenium WebDriver and Applitools Eyes.
Library     SeleniumLibrary

#Library     EyesLibrary       runner=web_ufg    config=applitools.yaml

# Declare setup and teardown routines.
Test Setup        Setup
#Test Teardown     Teardown

*** Variables ***
#Declare variables and lists. LOGIN-Credentials are in a list.
${LOGIN-BUTTON}   //*[@id="navbar"]/ul/li[2]/a
${URL}            http://hotel-v3.progmasters.hu 


@{LOGIN-Credentials-GUEST}   hogap65094@zamaneta.com   1234
@{Login-Credentials-Owner}   ribonot606@anawalls.com   1234

*** Keywords ***
# For setup, load the site main page and open Eyes to start visual testing.
Setup
    Open Browser    ${URL}      chrome
    Maximize Browser Window
    Title Should Be    title=Hotel
    #Eyes Open

Login_guest
    Click Element      ${LOGIN-BUTTON}
    Input Text        //*[@id="email"]   ${LOGIN-Credentials-GUEST}[0]
    Input Text        //*[@id="password"]   ${LOGIN-Credentials-GUEST}[1]
    Click Element     //*[@id="loginMember"]/div[3]/div/button

#Teardown
   # Eyes Close Async
   # Close All Browsers
   


*** Test Cases ***
# Login-guest

Log into guest account
    Click Element      ${LOGIN-BUTTON}
    # Verify the full login page loaded correctly.
   # Eyes Check Window    Login Page     Fully

    # Perform login.
    Input Text        //*[@id="email"]   ${LOGIN-Credentials-GUEST}[0]
    Input Text        //*[@id="password"]   ${LOGIN-Credentials-GUEST}[1]
    Click Element     //*[@id="loginMember"]/div[3]/div/button
    Capture Page Screenshot

    # Verify the full main page loaded correctly.
    # This snapshot uses LAYOUT match level to avoid differences in closing time text.
   # Eyes Check Window    Main Page    Fully    Match Level  LAYOUT

Log into owner account
    Click Element      ${LOGIN-BUTTON}
    # Verify the full login page loaded correctly.
  #  Eyes Check Window    Login Page     Fully

    # Perform login.
    Input Text        //*[@id="email"]   ${LOGIN-Credentials-Owner}[0]
    Input Text        //*[@id="password"]   ${Login-Credentials-Owner}[1]
    Click Element     //*[@id="loginMember"]/div[3]/div/button
    Capture Page Screenshot

    # Verify the full main page loaded correctly.
    # This snapshot uses LAYOUT match level to avoid differences in closing time text.
    #Eyes Check Window    Main Page    Fully    Match Level  LAYOUT
Booking as guest
    # Earlier determined
    Login_guest

    # Navigation of the random page/hotel
    Click Button  //*[@class="btn btn-outline-primary btn-block"]
    Wait Until Page Contains Element    //a[@class='page-link']    timeout=10s
    ${links}    Get WebElements    //a[@class='page-link' and @style='cursor: pointer'] 
    ${random_link}    Evaluate    random.choice($links)    random
    Wait Until Element Is Visible     ${random_link}    timeout=10s
    Click Element    ${random_link}
    Wait Until Page Contains Element    //button[contains(text(), 'Megnézem')]  timeout=10s
    Wait Until Element Is Enabled    //button[contains(text(), 'Megnézem')]    timeout=10s
    ${hotels}    Get WebElements    //button[contains(text(), 'Megnézem')]
    ${random_hotel}    Evaluate    random.choice($hotels)  random
    Click Element    ${random_hotel}
    
    # Booking parameters (number of guests and datum)
    Input Text    id:numberOfGuests    2
    Click Element  //input[@class="ng2-flatpickr-input flatpickr-input ng-star-inserted"]
    Press Keys      None    ARROW_UP      ARROW_RIGHT
    Press Keys      None    ENTER
    Press Keys      None    ARROW_UP      ARROW_RIGHT
    Press Keys      None    ENTER
    Press Keys      None    ENTER
    
    # Push "Foglalás" button
    Wait Until Element Is Enabled   //input[@style="width: 18px; height: 18px; cursor: pointer"]
    Select Checkbox    //input[@style="width: 18px; height: 18px; cursor: pointer"]
    Click Button    //button[@class="btn btn-warning mr-4"]

    # "ÁSZF" cheking
    Wait Until Element Is Visible     //input[@formcontrolname="aSZF"]
    Select Checkbox    //input[@formcontrolname="aSZF"]
    Click Button    //button[@class="btn btn-primary mr-4"]
    # Cheking of the succsesfull booking
    Wait Until Element Is Visible    //div[@class="modal-body"]/h5
    Element Should Be Visible    //div[@class="modal-body"]/h5
    
    # Finalising of booking
    Click Button    //button[@class="btn btn-primary mr-4"]

Delete of the Bookings
    #Earlier determined
    Login_guest

    # Navigation of the list of bookings
    Wait Until Element Is Visible    user-bookings
    Click Element    id:user-bookings

    Wait Until Element Is Visible     //button[@class="btn btn-primary mr-4 "]
    Click Button    //button[@class="btn btn-primary mr-4 "]
    Click Button    //button[@class="btn btn-primary"]
  
    # Loop of the Cancellation of reservations
  ${buttons}    Get WebElements    //button[@class="btn btn-primary mr-4 "]
    FOR  ${button}  IN     @{buttons}
      Wait Until Element Is Visible    ${button}
    Click Button    ${button}
    Wait Until Element Is Visible    //button[@class="btn btn-primary"]
    Click Button   //button[@class="btn btn-primary"]
    END
    
   

    

  


    

    
    
