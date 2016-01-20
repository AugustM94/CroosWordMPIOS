//
//  TileType.swift
//  crosswords
//
//  Created by August Møbius on 07/01/16.
//  Copyright © 2016 drades. All rights reserved.
//



enum TileType: Int{
    // Blank = Completely unused fields(usually marked with a grey field)
    case Description, Writeable, Empty
}

class Tile{
    private var text = ""
    private var result = ""
    let tileType: TileType
    
    
    init(tileType: TileType){
        self.tileType = tileType
        
    }
    /*
        getters and setters
    */
    func setText(text: String) {
        self.text = text
    }
    
    func getText() -> String{
        return self.text
    }
    
    func setResult(result: String) {
        self.result = result
    }
    
    func getResult() -> String{
        return self.result
    }
    
}



