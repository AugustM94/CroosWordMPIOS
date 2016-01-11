//
//  GameScene.swift
//  crosswords
//
//  Created by August Møbius on 07/01/16.
//  Copyright © 2016 drades. All rights reserved.
//
import SpriteKit
import UIKit



class GameScene: SKScene{
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var board: Board!
    let tileWidth: CGFloat = 50
    let tileHeight: CGFloat = 50
    
    let gameLayer = SKSpriteNode(color: UIColor.blueColor(), size: CGSizeMake(30, 30))
    let tileLayer = SKNode()
    let textLayer = UIView()
    
    let spriteSelected = SKSpriteNode(imageNamed: "tileSelected")
    
    var viewSize: CGSize
    
    override init(size: CGSize){
        viewSize = size
        super.init(size: size)
        anchorPoint = CGPoint(x:0.5, y:0.5)
        addChild(tileLayer)

    }
    

    
    func initializeSelectedTile(){
        spriteSelected.position = CGPoint(x: self.size.width * 5 , y: 0)
        tileLayer.addChild(spriteSelected)
    }
    
    func moveSelectedTile(sprite: SKSpriteNode, column: Int, row: Int){
        sprite.position = pointForColumn(column, row: row)
    }
    
    
    func addSpritesForTiles(tiles: Set<Tile>){
        for tile in tiles{
            let sprite = SKSpriteNode(imageNamed: "tile")
            sprite.position = pointForColumn(tile.column,row: tile.row)
            tileLayer.addChild(sprite)
            tile.sprite = sprite
        }
    }
    
    func addTextFieldForTiles(tiles: Set<Tile>) {
        for tile in tiles{
            let textField = UITextField()
            textField.frame = CGRectMake(CGFloat(tile.column) * tileWidth + viewSize.width / 2, (CGFloat(tile.row) * tileHeight + viewSize.height / 2) - tileHeight * CGFloat(numRows), tileWidth, tileHeight)
            //textField.backgroundColor = UIColor.brownColor()
            textField.textAlignment = .Center
            tile.textField = textField
            
        }
    }
    
    
    
    func pointForColumn(column: Int, row: Int) -> CGPoint {
        return CGPoint(x: CGFloat(column) * tileWidth + tileWidth/2, y: CGFloat(row) * tileHeight + tileHeight/2)
    }
    
    //func checkMaxLength(textfield: UITextField!)

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches{
            let location = touch.locationInNode(tileLayer)
            let (success, column, row) = columnForPoint(location)
            print(touch)
            if success{
                moveSelectedTile(spriteSelected, column: column, row: row)
                if let tile = board.tileAtColumn(column, row: row){
                }
            }
            
            
        }
    }
    
    //Get row and column for clicked tile
    func columnForPoint(point: CGPoint) -> (success: Bool, coloumn: Int, row: Int){
        if(point.x >= 0 && point.x <= tileWidth * CGFloat(numColumns)
            && point.y >= 0 && point.y <= tileHeight * CGFloat(numRows)){
            return (true, Int(point.x/tileWidth),Int(point.y/tileHeight))
        }
        
        
        return (false, 0,0)
    }
    
    
    
    
    

    
    
    

}