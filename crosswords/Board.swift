//
//  Board.swift
//  crosswords
//
//  Created by August Møbius on 07/01/16.
//  Copyright © 2016 drades. All rights reserved.
//

import Foundation

var numColumns = 0
var numRows = 0

class Board {
    private var tiles: Array2D<Tile>!
    
    //Builds the board, creates tiles
    init(){
        if let dictionary = Dictionary<String, AnyObject>.loadJSONFromBundle("CWPuzzle") {
            numColumns = dictionary["numColumns"] as! Int
            numRows = dictionary["numRows"] as! Int
            tiles = Array2D<Tile>(columns: numColumns, rows: numRows)
            if let tilesArray: AnyObject = dictionary["board"] {
                for (row, rowArray) in (tilesArray as! [[Int]]).enumerate() {
                    for (column, type) in rowArray.enumerate() {
                        let tile = Tile(tileType: TileType(rawValue: type)!)
                        tiles[column,row] = tile
                    }
                }
            }
            
            if let tilesArray: AnyObject = dictionary["content"] {
                for (row, rowArray) in (tilesArray as! [[String]]).enumerate() {
                    for (column, text) in rowArray.enumerate() {
                        let tile = tiles[column,row]
                        if tile?.tileType == TileType.Description {
                            tile!.setText(text)
                        } else if tile?.tileType == TileType.Writeable  {
                            tile!.setResult(text)
                        }
                    }
                }
            }
        }
    }
    
    
    
    func tileAtColumn(column: Int, row: Int) -> Tile!{
        assert(column >= 0 && column < numColumns)
        assert(row >= 0 && row < numRows)
        return tiles[column,row]
    }
    
    
    func updateBoardContent(boardContent: NSArray){
        for row in 0..<numRows {
            for column in 0..<numColumns {
                let boardArrayColumn = boardContent[row] as! NSArray
                if let newText =  boardArrayColumn[column] as? String {
                    tileAtColumn(column, row: row).setText(newText)
                }
            }
        }
    }
    
    //Hard coded solution(Not flexible)
    func checkIfCrossWordComplete() -> Bool{
        for row in 0..<numRows {
            for column in 0..<numColumns {
                let tile = tileAtColumn(column, row: row)
                if tile.tileType == TileType.Writeable {
                    if tile.getText() != tile.getResult() {
                        print("\(tile.getText()) and \(tile.getResult())")
                        return false
                    }
                }
            }
        }
        print("You won")
        return true
    }
    
    
    func getTilesArray() -> Array2D<Tile>{
        return tiles
    }
}