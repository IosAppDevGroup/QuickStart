//
//  QuickStartTests.swift
//  QuickStartTests
//
//  Created by Flonly on 7/23/16.
//  Copyright © 2016 FlonlyIos. All rights reserved.
//

import XCTest
@testable import QuickStart

class QuickStartTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testMealInit(){
        let noPhoto = Meal(name: "xxx", photo: nil, rating: 0)
        XCTAssertNotNil(noPhoto)
        
        let emptyName = Meal(name: "", photo: nil, rating: 0)
        XCTAssertNil(emptyName)
        
        let badRating = Meal(name: "ok", photo: nil, rating: -1)
        XCTAssertNil(badRating)
    }
    
}
