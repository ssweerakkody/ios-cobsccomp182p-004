//
//  SunethShehan_cobsccomp182p_004Tests.swift
//  SunethShehan-cobsccomp182p-004Tests
//
//  Created by Suneth on 2/3/20.
//  Copyright © 2020 Suneth. All rights reserved.
//

import XCTest
@testable import SunethShehan_cobsccomp182p_004

class SunethShehan_cobsccomp182p_004Tests: XCTestCase {

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
    
    func testPasswords(){
    
        
        FormValidation.isEqualPasswords(password: <#T##UITextField#>, confirmPassword: <#T##UITextField#>, presentingVC: <#T##UIViewController#>)
        
    }

}
