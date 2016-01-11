//
//  TileType.swift
//  crosswords
//
//  Created by August Møbius on 07/01/16.
//  Copyright © 2016 drades. All rights reserved.
//

import SpriteKit

enum TileType: Int{
    // Blank = Completely unused fields(usually marked with a grey field)
    case Type = 0, Description, Writeable, Blank
    static func getWriteableTile() -> TileType{
        return TileType(rawValue: 2)!
    }
}

class Tile: Hashable {
    var column: Int
    var row: Int
    var sprite: SKSpriteNode?
    var textField: UITextField?
    let tileType: TileType
    
    init(column: Int, row: Int, tileType: TileType){
        self.column = column
        self.row = row
        self.tileType = tileType
        
    }
    
    var hashValue: Int{
        return row*2 + column
    }
    
    
}

func ==(lhs: Tile, rhs: Tile) -> Bool{
    return lhs.column == rhs.column && lhs.row == rhs.row
}


