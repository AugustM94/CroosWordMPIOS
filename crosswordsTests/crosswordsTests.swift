//
//  crosswordsTests.swift
//  crosswordsTests
//
//  Created by August Møbius on 12/01/16.
//  Copyright © 2016 drades. All rights reserved.
//

import XCTest
@testable import crosswords

class crosswordsTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTileContent() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let board = Board()
        
        board.createInitialTiles()
        
        let descriptionTileTest = Tile(text: "1:", tileType: TileType.Description)
        let writetableTileTest = Tile(text: "", tileType: TileType.Writeable)
        let descriptionTile = board.getTilesArray()[0,0]!
        let writableTile = board.getTilesArray()[1,0]!
        
        // Test the desciption tile known to be at 0,0
        XCTAssertEqual(descriptionTile.tileType, descriptionTileTest.tileType)
        XCTAssertEqual(descriptionTile.text, descriptionTileTest.text)
        
        // Test the writable tile known to be at 1,0
        XCTAssertEqual(writableTile.tileType, writetableTileTest.tileType)
        XCTAssertEqual(writableTile.text, writetableTileTest.text)
        
        // Test 
    }
    
        
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
/*
class Tile: Equatable {
    var tileType: TileType
    var text: String
    
    init(tileType: TileType, text: String){
        self.tileType = tileType
        self.text = text
    }
}

func ==(lhs: Tile, rhs: Tile) -> Bool {
    return lhs.text == rhs.text && lhs.tileType == rhs.tileType
}

*/