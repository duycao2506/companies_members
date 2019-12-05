//
//  BindableTest.swift
//  CompaniesMembersTests
//
//  Created by Deskera on 12/04/19.
//  Copyright © 2019 Duy Cao. All rights reserved.
//

import XCTest

@testable import CompaniesMembers

class BindableTest: XCTestCase {

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
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
    }
    
    func testBind() {
        let bindaleObject = Bindable<String>("")
        var notifiedValue: String?
        
        bindaleObject.bind { (value) in
            notifiedValue = value
        }
        
        bindaleObject.value = "Test value"
        XCTAssertEqual(notifiedValue, "Test value")
    }
    
    func testBindAndFire() {
        let bindaleObject = Bindable<String>("")
        var notifiedValue: String?
        bindaleObject.value = "Test bind and fire event"
        
        bindaleObject.bindAndFireEvent { (value) in
            notifiedValue = value
        }
            
        XCTAssertEqual(notifiedValue, "Test bind and fire event")
    }
    
    func testBindWithArray() {
        let bindObject = Bindable<[Int]>([])
        var count = 0
        
        bindObject.bind { (value) in
            count = bindObject.value.count
        }
        
        bindObject.value = [1, 2]
        
        XCTAssertEqual(count, 2)
    }
}
