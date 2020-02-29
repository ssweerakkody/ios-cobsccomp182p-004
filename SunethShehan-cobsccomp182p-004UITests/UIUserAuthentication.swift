//
//  UIUserAuthentication.swift
//  SunethShehan-cobsccomp182p-004UITests
//
//  Created by Suneth on 3/1/20.
//  Copyright © 2020 Suneth. All rights reserved.
//

import XCTest

class UIUserAuthentication: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testUIUserAuthentication(){
        
        
        let app = XCUIApplication()
        let signInButton = app.buttons["Sign In"]
        signInButton.tap()
        
        let okButton = app.alerts["Check input"].buttons["OK"]
        okButton.tap()
        
        let usernameOrEmailTextField = app.textFields["Username or email"]
        usernameOrEmailTextField.tap()
        signInButton.tap()
        okButton.tap()
        app.secureTextFields["Password"].tap()
        signInButton.tap()
        app.alerts["Eror"].buttons["OK"].tap()
        usernameOrEmailTextField.tap()
        signInButton.tap()
        

        
        
    }
    

}
