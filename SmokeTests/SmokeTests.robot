*** Settings ***
Documentation       The following tests are smoke tests for http://automationpractice.com/index.php?.
...                 The keywords live in Verodin/SmokeTests/SmokeTestKeywords/SmokeTest.robot.
Suite Setup         Open Browser To Homepage
Test Teardown       Direct Nav To Homepage
Suite Teardown      Close All Browsers
Resource            SmokeTestKeywords.robot

*** Variables ***
# validEmail needs to be updated daily due to the website's account resets. This can be done by running the first test
# and checking the log.
${validEmail}       02162019.032839@test.com
${validPassword}    jo(4Mh51K
${invalidPassword}  99999999

*** Test Cases ***
Verify User Is Able To Create An Account
    [Setup]     logout if logged in
    ${dateTime}=        get current date        result_format=%m%d%Y.%I%M%S
    &{accountInfo}=     create dictionary       email=${dateTime}@test.com      firstName=Will      lastName=Forte
    ...                                         password=${validPassword}       address=123 Test st.
    ...                                         city=Testville                  state=Nevada        zip=01234
    ...                                         phone=0123456789
    log                 ${accountInfo}
    nav to sign in page from homepage
    create account from sign in page            ${accountInfo}

Verify Valid User Can Sign In
    [Setup]     logout if logged in
    nav to sign in page from homepage
    sign in successfully            ${validEmail}       ${validPassword}

Verify User Cannot Sign In With Invalid Credentials
    [Setup]     logout if logged in
    nav to sign in page from homepage
    sign in unsuccessfully          ${validEmail}       ${invalidPassword}

Verify User Can Sign Out
    [Setup]     login if logged out     ${validEmail}       ${validPassword}
    logout from homepage

Verify User Can Access Women Clothing Page
    nav to women clothing page from homepage

Verify User Can Add Item To Cart From Women Page
    [Setup]     login if logged out     ${validEmail}       ${validPassword}
    nav to women clothing page from homepage
    add item to cart from womens page
    verify item added to cart

Verify User Can Access Dresses Page
    nav to dresses page from homepage

Verify User Can Add Item To Cart From Dresses Page
    nav to dresses page from homepage
    add item to cart from dresses page
    verify item added to cart

# --- ToDo: Implement The Following Test Cases ---

# Verify User Can Access T-Shirts Page

# Verify User Can Add Item To Cart From T-Shirts Page

# Verify User Can Access Account Page

# Verify User Can Access Contact Us Page

