//
//  Board.swift
//  crosswords
//
//  Created by August Møbius on 07/01/16.
//  Copyright © 2016 drades. All rights reserved.
//

let numColumns = 2
let numRows = 1

class Board {
    private var tiles = Array2D<Tile>(columns: numColumns, rows: numRows)
    
    func tileAtColumn(column: Int, row: Int) -> Tile!{
        assert(column >= 0 && column < numColumns)
        assert(row >= 0 && row < numRows)
        return tiles[column,row]
    }

    
    func createInitialTiles(){
        
        for row in 0..<numRows {
            for column in 0..<numColumns {
                let tileType = TileType.Writeable
                let tile = Tile(tileType: tileType)
                tiles[column,row] = tile
            }
        }
        let tileType = TileType.Description
        let tile = Tile(tileType: tileType)
        tiles[0,0] = tile
    }
    
    func getTilesArray() -> Array2D<Tile>{
        return tiles
    }
}
