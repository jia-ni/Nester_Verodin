# Verodin Project w/ Robot Framework

## Introduction
The smoke tests for this project were created for http://automationpractice.com/ and
were done using Robot Framework. Robot Framework is an open-source testing 
framework that is primarily built on python and is intended to be used for GUI & 
API acceptance testing. Multiple IDEs support Robot, however these installation
instructions are specifically written for PyCharm.

This readme gives an overview of how to use Robot Framework, but the [Robot Framework User Guide](http://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html)
is a great resource when trying to find information that isn't covered in this write-up.

#### Scope of Implemented Smoke Tests
The purpose of smoke tests is to ensure that the basic functions of the platform are accessible.
If the smoke tests pass, then it is worth continuing testing at a more detailed level. However,
if the smoke tests fail, then the product doesn't function properly at the most basic level and
therefore the build is in too poor of a state to continue testing.

In the case of automationpractice.com, the website acts as a clothing retail store. The major
functions of this website are the various webpages, ability to create a new account,
ability to sign in/out of an account and the shopping cart.

Currently, the test cases live in SmokeTests.robot and the following 
have been implemented:
* Verify User Is Able To Create An Account
* Verify Valid User Can Sign In
* Verify User Cannot Sign In With Invalid Credentials
* Verify User Can Sign Out
* Verify User Can Access Women Clothing Page
* Verify User Can Add Item To Cart From Women Page
* Verify User Can Access Dresses Page
* Verify User Can Add Item To Cart From Dresses Page

A few tests were left out and are intended to be used as practice. These
test cases are commented out at the bottom of SmokeTests.robot and are
similar to those that have already been implemented.
## Set Up
If everything was packaged together correctly, the Verodin project should already contain all of
the necessary tools aside from PyCharm and the ChromeDriver. In that case, only the PyCharm
and ChromeDrive sections of the Set Up are necessary, but it is worth reading the installation
steps for the Robot Framework Plugin, External Tools and Zoomba library sections to verify this.
#### PyCharm
Download PyCharm [here](https://www.jetbrains.com/pycharm/download/#section=windows)
and follow the installation instructions.
#### ChromeDriver
In order for the GUI tests to work, the ChromeDriver needs to be downloaded and added to PATH. 
ChromeDriver can be downloaded [here](https://sites.google.com/a/chromium.org/chromedriver/).
Then follow [these instructions](https://docs.telerik.com/teststudio/features/test-runners/add-path-environment-variables)
to add chromedriver.exe to PATH.
#### Robot Framework Plugin
With the Verodin project open, go to: _File > Settings > Plugins_ then search for and install 
*Robot Framework Support*. The search results should show four items, but only 
_Robot Framework Support_ is needed.

Next, create the tools used to run the tests. Go to: 
_File > Settings > Tools > External Tools_ and click the Add button (Alt+Insert).
Fill in the following information then hit Okay:
* Name: Robot
* Program: $PyInterpreterDirectory$/python
* Arguments: -m robot -t "$SelectedText$" -d Results $FileName$
* Working Directory: $FileDir$

Next, add this tool:
* Name: Robot Full Suite
* Program: $PyInterpreterDirectory$/python
* Arguments: -m robot -d Results $FileName$
* Working Directory: $FileDir$
#### The Zoomba Library
The Zoomba library adds several keywords to Robot which allow for more reliable
testing. To install the Zoomba library:
Go to: _File > Settings > Project: Verodin > Project Interpreter_.
In the top right corner of the window, click on the Add button (Alt+Insert) and
search for *robotframework-zoomba* then click install. There should only be one 
result, which is on version 1.6.4.
## Writing & Running Test Cases
#### Test Cases
Test cases in Robot Framework have the following format:

```robotframework
*** Test Cases ***
Test Name
    [Documentation]     This section is for notes.
    Keyword 1
    Keyword 2  ${argument1}  ${argument2}
    Keyword 3
```
Notice that there are two spaces in between Keyword 2 and its arguments. Robot 
separates keywords and arguments by two or more spaces. The *** Test Cases ***
header defines where in the .robot file that the test cases live. This is explained
in more detail in the Test Suite section.

To run the test:
1. Highlight the test's name.
2. _Right Click in the editor > External Tools > Robot_
#### Keywords
Keywords are the functions that make up a test. Keywords are defined in a section
of the .robot file which has the header *** Keywords ***. Keywords are generally
made up of other keywords, including built-in and user defined keywords, but can 
also be created using python or java. See [this page](http://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#creating-test-libraries)
for more information.

In the following example, the *Navigate To Homepage* keyword opens a browser, navigates to the 
url that it takes as an argument, then closes the browser.
```robotframework
*** Keywords ***
Navigate To Homepage
    [Arguments]     ${url}
    Open Browser
    Go To           ${url}
    Close Browser
```
This keyword can then be called by any test cases that also live in the same
.robot file. More information on keywords, and a list of built in keywords can be
found in the following links:
* [Creating User Keywords](http://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#creating-user-keywords)
* [Robot Framework Build In](http://robotframework.org/robotframework/latest/libraries/BuiltIn.html#Set%20Variable)
* [Selenium2Library](http://robotframework.org/Selenium2Library/Selenium2Library.html)
* [Zoomba](https://github.com/Accruent/zoomba/tree/master/src/Zoomba)
#### Variables
There are three different types of variables in robot framework: Scalars, Lists and
Dictionaries. Variables can be defined with the following format:
```robotframework
*** Variables ***
${var1}     This variable is a scalar.
@{var2}     listItem1   listItem2   listItem3
&{var3}     key1=Value1     key2=Value2     key3=Value3
```
Notice that ${var1}, @{var2}, and &{var3} are a scalar, list and dictionary, 
respectively. Variables can also be defined within the scope of a test or keyword.
```robotframework
Variable Keyword
    ${var1}=    Set Variable        This is a scalar.
    @{var2}=    Create List         item1   item2   item3    
    &{var3}=    Create Dictionary   key1=Value1     key2=Value2
    Log         ${var1}
    Log         ${var2}
    Log         &{var3}
```
More information on variables can be found [here](http://robotframework.org/robotframework/latest/libraries/BuiltIn.html#Set%20Variable).
#### Test Suites
Test suites are .robot files that bring everything together. To run an entire test
suite:

*Right Click in the editor > External Tools > Robot Full Suite*. A typical test suite will 
look something like this:
```robotframework
*** Settings ***
Documentation       This suite contains sample tests.
Suite Setup         Open Browser
Test Setup          Login
Test Teardown       Logout
Suite Teardown      Close All Browsers
Resource            MoreKeywords.robot

*** Variables ***
${var1}         Hello, world.
@{list1}        foo     bar

*** Test Cases ***
Validate Account Page Is Accesible
    Nav To My Account
    Verify Account Page Loads
    
Validate Help Page Is Accesible
    Nav To Help Page
    Verify Help Page Loads
    
*** Keywords ***
Nav To Help Page
    Wait For And Click On Element       //HelpPageButtonXpath
    
Verify Help Page Loads
    Wait Until Page Contains        //HelpPageElement1
    Wait Until Page Contains        //HelpPageElement2
    Wait Until Page Contains        //HelpPageElement3
```
Notice that the Variables, Keywords and Test Cases all live in the test suite, along with
an additional Settings section. The settings section includes: 
* Documentation
    * Argument: A description of the test suite.
* Suite Setup/Teardown
    * Argument: A keyword to run before/after the entire suite is ran. Use the Built-In
    keyword *Run Keywords* if trying to run multiple keywords in the setup or
    teardown.
* Test Setup/Teardown
    * Argument: A keyword to run before/after each test is ran.
* Resource
    * Argument: A file path to another .robot file which allows the use of its keywords.

More information on test suites can be found [here](http://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#creating-test-suites).
