*** Settings ***
Library     Zoomba.GUILibrary
Library     DateTime

*** Keywords ***
Open Browser To Homepage
    Open Browser                http://automationpractice.com/index.php?    Chrome
    Verify Homepage Is Loaded

Verify Homepage Is Loaded
    wait until page contains element        //div[@id='page']
    wait until page contains element        //header[@id='header']
    wait until page contains element        //div[@id='columns']
    wait until page contains element        //footer[@id='footer']

Nav To Women Clothing Page From Homepage
    wait for and click element              //div[@id='page']//div[@id='block_top_menu']//a[contains(@title, 'Women')]
    verify women clothing page is loaded

Verify Women Clothing Page Is Loaded
    title should be                         Women - My Store
    wait until page contains element        //div[@id='page']
    wait until page contains element        //div[@class='header-container']
    wait until page contains element        //div[@class='columns-container']
    wait until page contains element        //div[@class='footer-container']

Nav To Sign In Page From Homepage
    wait for and click element          //div[@id='page']//div[@class='header_user_info']//a[@class='login']
    wait for and focus on element       //div[@id='page']

Create Account From Sign In Page
    [Arguments]     ${accountInfo}
    wait for and input text     //div[@id='center_column']//input[@id='email_create']                   &{accountInfo}[email]
    wait for and click element  //div[@id='center_column']//button[@id='SubmitCreate']
    wait for and input text     //div[@class='account_creation']//input[@id='customer_firstname']       &{accountInfo}[firstName]
    wait for and input text     //div[@class='account_creation']//input[@id='customer_lastname']        &{accountInfo}[lastName]
    wait for and input text     //div[@class='account_creation']//input[@id='email']                    &{accountInfo}[email]
    wait for and input text     //div[@class='account_creation']//input[@id='passwd']                   &{accountInfo}[password]
    wait for and input text     //div[@class='account_creation']//input[@id='firstname']                &{accountInfo}[firstName]
    wait for and input text     //div[@class='account_creation']//input[@id='lastname']                 &{accountInfo}[lastName]
    wait for and input text     //div[@class='account_creation']//input[@id='address1']                 &{accountInfo}[address]
    wait for and input text     //div[@class='account_creation']//input[@id='city']                     &{accountInfo}[city]
    select from list by label   //div[@class='account_creation']//select[@id='id_state']                &{accountInfo}[state]
    wait for and input text     //div[@class='account_creation']//input[@id='postcode']                 &{accountInfo}[zip]
    wait for and input text     //div[@class='account_creation']//input[@id='phone_mobile']             &{accountInfo}[phone]
    wait for and click element      //div[@id='page']//button[@id='submitAccount']
    wait for and focus on element   //div[@id='page']//div[@id='center_column']

Sign In Successfully
    [Arguments]     ${email}        ${password}
    wait for and input text         //form[@id='login_form']//input[@id='email']        ${email}
    wait for and input text         //form[@id='login_form']//input[@id='passwd']       ${password}
    wait for and click element      //button[@id='SubmitLogin']
    wait for and focus on element   //div[@id='page']//div[@id='center_column']
    element should not be visible   //div[@id='page']//div[@id='center_column']//div[@class='alert alert-danger']

Sign In Unsuccessfully
    [Arguments]     ${email}        ${password}
    wait for and input text         //form[@id='login_form']//input[@id='email']        ${email}
    wait for and input text         //form[@id='login_form']//input[@id='passwd']       ${password}
    wait for and click element      //button[@id='SubmitLogin']
    element should contain          //div[@id='page']//div[@id='center_column']//li     Authentication failed.

Direct Nav To Homepage
    ${url}=                         Set Variable        http://automationpractice.com
    go to                           ${url}
    verify homepage is loaded

Logout If Logged In
    [Documentation]     This keyword requires to be ran from the homepage.
    ${loggedIn}=        run keyword and return status       wait for and focus on element       //*[@id="header"]/div[2]/div/div/nav/div[1]/a[@class='account']
    log                 ${loggedIn}
    run keyword if      '${loggedIn}'=='True'                 logout from homepage
    direct nav to homepage

Logout From Homepage
    wait for and click element          //div[@id='page']//a[@title='Log me out']
    wait until page contains element    //div[@id='page']//a[contains(@title,'Log in to your customer account')]

Login If Logged Out
    [Documentation]     This keyword requires to be ran from the homepage.
    [Arguments]         ${validEmail}       ${validPassword}
    ${loggedIn}=        run keyword and return status       wait for and focus on element       //div[@id='page']//a[contains(@title,'Log in to your customer account']
    log                 ${loggedIn}
    run keyword if      '${loggedIn}'!='True'               run keywords                        nav to sign in page from homepage
    ...         AND                                         sign in successfully                ${validEmail}       ${validPassword}
    ...         AND     direct nav to homepage

Add Item To Cart From Womens Page
    wait for and focus on element       //div[@id='center_column']//ul//li[2]//img[@title='Blouse']
    wait for and click element          //div[@id="center_column"]//ul//li[2]//a[@title='Add to cart']

Verify Item Added To Cart
    wait for and focus on element       //div[@id='page']//div[@id='layer_cart']

Nav To Dresses Page From Homepage
    wait for and click element          //div[@id="block_top_menu"]/ul/li[2]/a
    verify dresses page is loaded

Verify Dresses Page Is Loaded
    title should be                         Dresses - My Store
    wait until page contains element        //div[@id='page']
    wait until page contains element        //div[@class='header-container']
    wait until page contains element        //div[@class='columns-container']
    wait until page contains element        //div[@class='footer-container']

Add Item To Cart From Dresses Page
    wait for and focus on element       //div[@id="center_column"]/ul/li[5]/div/div[2]/div[2]/a[1]
    wait for and click element          //div[@id="center_column"]//ul//li[2]//a[@title='Add to cart']

Nav To Homepage And Logout If Logged In
    direct nav to homepage
    logout if logged in