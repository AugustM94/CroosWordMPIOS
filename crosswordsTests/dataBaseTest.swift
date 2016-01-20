//
//  dataBaseTest.swift
//  crosswords
//
//  Created by August Møbius on 17/01/16.
//  Copyright © 2016 drades. All rights reserved.
//

import XCTest
import Foundation
@testable import crosswords

class dataBaseTest: XCTestCase {

    var dataManager = DataManager()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testRemoteBoardContent() {
        // Test that the array is nil before calling the database
        XCTAssertNil(dataManager.remoteBoardContent)
        
        // Call the data base.
        dataManager.getDataFromRemote()

        //XCTAssertNotNil(dataManager.remoteBoardContent)
    }
    
    func testParseNewUserInput() {
        
    }



}
