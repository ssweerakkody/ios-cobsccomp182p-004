//
//  UserAuthenticationTest.swift
//  SunethShehan-cobsccomp182p-004Tests
//
//  Created by Suneth on 2/29/20.
//  Copyright © 2020 Suneth. All rights reserved.
//

import XCTest
import Firebase
import UIKit
@testable import SunethShehan_cobsccomp182p_004

class UserAuthenticationTest: XCTestCase {

     var firebaseAuth = Auth.auth()
    override func setUp() {
       
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func validateUserInputs(){
        
        let loginVC = LoginViewController()
        loginVC.txtEmail.text = "dummy@mail.com"
        loginVC.txtPassword.text = "123456"
        
        XCTAssertTrue(loginVC.validateInputs(), "Valid Inputs")
        
        
    }
    
    func testUserAuthentication() {
        

        FAuthClient.signInUser(email: "dummyuser@mail.com", password: "123456", presentingVC: UIViewController()) { (user) in
            if(user != nil)
            {
                XCTAssertNotNil(user, "Login Success")
            }
            else
            {
                XCTFail("Login Failed")
            }
        
        }
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
