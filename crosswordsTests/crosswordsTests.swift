//
//  crosswordsTests.swift
//  crosswordsTests
//
//  Created by August Møbius on 14/01/16.
//  Copyright © 2016 drades. All rights reserved.
//

import XCTest
@testable import crosswords

class crosswordsTests: XCTestCase {
    
    var board = Board()
    
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
    
    func testSuccessfulCheck(){

        //Test: No input - Should return false
        XCTAssertFalse(board.checkIfCrossWordComplete())

        //Set all textfields to the expected value
        for row in 0..<numRows {
            for column in 0..<numColumns {
                let tile = board.tileAtColumn(column, row: row)
                if tile.tileType == TileType.Writeable {
                    tile.text = tile.result
                }
            }
        }
        //Test that the correct input returns true
        XCTAssertTrue(board.checkIfCrossWordComplete())
        
        
        //Test that a wrong input returns false
        //Change one paramter
        let tile = board.tileAtColumn(1, row: 0)
        tile.text = "B"
        XCTAssertFalse(board.checkIfCrossWordComplete())
        
    }
    
    func testCorrectBoardInitialization(){
        board = Board()
        
        //Test: Crossword checks if it is compelted af filled.
        XCTAssertFalse(board.checkIfCrossWordComplete())


        
        //Test: Check that all writeable fields are initially an empty string - Expected: True
        for row in 0..<numRows {
            for column in 0..<numColumns {
                let tile = board.tileAtColumn(column, row: row)
                if tile.tileType == TileType.Writeable {
                    XCTAssertEqual("",tile.text)
                } else if tile.tileType == TileType.Description {
                    XCTAssertNotEqual("",tile.text)
                }
            }
        }
        //Test: That the field on 0,0 is of type description - Should return true
        XCTAssertEqual(TileType.Description,board.tileAtColumn(0,row: 0).tileType)
        //Test that the correct input returns true
        XCTAssertFalse(board.checkIfCrossWordComplete())
    }


    func testTileAtColumn() {
        //Access a tile
        //XCTAssert((board.tileAtColumn(1, row: 0)) != nil)
    }
    
    
    
    
    
    
}
