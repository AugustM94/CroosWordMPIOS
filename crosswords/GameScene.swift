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
    private var tiles = Array2D<Tile>(columns: numColumns, rows: numRows)
    private var tileNodes = Array2D<SKNode>(columns: numColumns, rows: numColumns)
    
    var activeColumn: Int!
    var activeRow: Int!
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
    
    func addSpritesForTiles(tiles: Array2D<Tile>){
        for row in 0..<numRows {
            for column in 0..<numColumns {
                tileTypeHandler(column, row: row, tileType: board.tileAtColumn(column, row: row).tileType)
            }
        }
    }
    
    func updateLabel(column: Int, row: Int){
        let text = board.tileAtColumn(column, row: row).text!
        let label: SKLabelNode = tileNodes[column,row]?.childNodeWithName("label") as! SKLabelNode
        label.text = text
    }
    
    
    // Sets the view objects for a tile
    func tileTypeHandler(column: Int, row: Int, tileType: TileType){
        let sprite = SKSpriteNode(imageNamed: "tile")
        sprite.position = pointForColumn(column,row: row)
        var node = tileNodes[column,row]
        node!.addChild(sprite)
        let label = SKLabelNode()
        label.position = pointForColumn(column, row: row)
        label.name = "label"
        //Bring the label to front
        label.zPosition = 1
        label.verticalAlignmentMode = .Center
        label.fontName = "HelveuticaNeue-Bold"
        node!.addChild(label)
        tileLayer.addChild(node!)
    }
    
    
    func createInitialTileNodes(){
        for row in 0..<numRows {
            for column in 0..<numColumns {
                let node = SKNode()
                tileNodes[column,row] = node
            }
        }
    }
    
    func setActiveField(column: Int, row: Int){
        activeColumn = column
        activeRow = row
        print("Selected field: \(activeColumn),\(activeRow)")
    }

    func pointForColumn(column: Int, row: Int) -> CGPoint {
        return CGPoint(x: CGFloat(column) * tileWidth + tileWidth/2, y: CGFloat(row) * tileHeight + tileHeight/2)
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