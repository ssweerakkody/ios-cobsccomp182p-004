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

    override func setUp() {
       
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testEmailValidity(){
        
        let txtEmail = UITextField()
        txtEmail.text = "dummy@mail.com"
        XCTAssertTrue(FormValidation.isValidEmail(txtEmail.text!, presentingVC: UIViewController()), "Valid Email")
    }
    
    func testPasswordValidity(){
        
        let txtPassword = UITextField()
        txtPassword.text = "123456"
        
        XCTAssertTrue(FormValidation.isValidEmail(txtPassword.text!, presentingVC: UIViewController()), "Valid Password")
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

}
