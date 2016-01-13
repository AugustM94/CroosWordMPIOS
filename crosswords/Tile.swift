//
//  TileType.swift
//  crosswords
//
//  Created by August Møbius on 07/01/16.
//  Copyright © 2016 drades. All rights reserved.
//



enum TileType: Int{
    // Blank = Completely unused fields(usually marked with a grey field)
    case Description, Writeable
}

class Tile{
    var text = ""
    let tileType: TileType
    
    init(tileType: TileType){
        self.tileType = tileType
        
    }
    

}



