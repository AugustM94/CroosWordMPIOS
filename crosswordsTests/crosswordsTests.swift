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
    
    //Tests with correct input and no input
    func testSuccessfulCheck1(){

        //Test: No input - Should return false
        XCTAssertFalse(board.checkIfCrossWordComplete())

        //Set all textfields to the expected value
        for row in 0..<numRows {
            for column in 0..<numColumns {
                let tile = board.tileAtColumn(column, row: row)
                if tile.tileType == TileType.Writeable {
                    tile.setText(tile.getResult())
                }
            }
        }
        //Test that the correct input returns true
        XCTAssertTrue(board.checkIfCrossWordComplete())
        
        

        
    }
    //Tests with incorrect in inputs
    func testSuccessfulCheck2(){
        board = Board()
        board.tileAtColumn(1, row: 0).setText("A")
        board.tileAtColumn(2, row: 0).setText("A")
        board.tileAtColumn(3, row: 0).setText("A")
        
        //Test that wrong input returns false.
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
                    XCTAssertEqual("",tile.getText())
                } else if tile.tileType == TileType.Description {
                    XCTAssertNotEqual("",tile.getText())
                }
            }
        }
        //Test: That the field on 0,0 is of type description - Should return true
        XCTAssertEqual(TileType.Description,board.tileAtColumn(0,row: 0).tileType)
        //Test that the correct input returns true
        XCTAssertFalse(board.checkIfCrossWordComplete())
    }


    func testChangeTileTextAtColumn() {
        //Create the board.
        board = Board()
        //Test if the writeable tile text is empty before the text is changed/added
        XCTAssertEqual(board.tileAtColumn(1, row: 0).getText(), "")
        
        //Change the tile text:
        board.changeTileTextAtColumn(1, row: 0, text: "A")
        //Test if the tile text has been changed to "A"
        XCTAssertEqual(board.tileAtColumn(1, row: 0).getText(), "A")

    }
    
    
    
    
    
    
    
}
