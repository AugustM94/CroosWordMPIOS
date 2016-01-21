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
    
    var hintIndex = 1
    
    let tileWidth: CGFloat = 50
    let tileHeight: CGFloat = 50
    
    let tileLayer = SKNode()
    
    let spriteSelected = SKSpriteNode(imageNamed: "tileSelected")
    
    private var tileNodes = Array2D<SKNode>(columns: numColumns, rows: numRows)
    
    var activeColumn: Int!
    var activeRow: Int!
    
    var viewSize: CGSize
    
    override init(size: CGSize){
        viewSize = size
        super.init(size: size)
        self.backgroundColor = UIColor(red: 223/255, green: 222/255, blue: 222/255, alpha: 1)
        anchorPoint = CGPoint(x:0.5, y:0.5)
        spriteSelected.anchorPoint = CGPoint(x:0.0, y:0.0)
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
                tileTypeHandler(column, row: row, type: tiles[column, row]!.tileType)
            }
        }
    }
    
    func updateLabel(column: Int, row: Int, text: String){
        let label: SKLabelNode = tileNodes[column,row]?.childNodeWithName("label") as! SKLabelNode
        label.text = text
    }
    
    // Sets the view objects for a tile
    func tileTypeHandler(column: Int, row: Int, type: TileType){
        var sprite = SKSpriteNode(imageNamed: "tile")
        if type == TileType.Empty{
            sprite = SKSpriteNode(imageNamed: "tileEmpty")
        }
        sprite.anchorPoint = CGPoint(x:0.0, y:0.0)
        sprite.position = pointForColumn(column,row: row)
        let node = tileNodes[column,row]
        
        node!.addChild(sprite)
        let label = SKLabelNode()
        label.position = pointForColumn(column, row: row)
        label.position = CGPointMake(label.position.x + tileWidth/2, label.position.y + tileHeight/2)
        label.name = "label"
        //Bring the label to front
        label.zPosition = 1
        label.verticalAlignmentMode = .Center
        label.fontName = "HelveuticaNeue-Bold"
        label.fontColor = UIColor.blackColor()
        node!.addChild(label)
        if type == TileType.Description{
            let hintIndexLabel = SKLabelNode()
            hintIndexLabel.position = pointForColumn(column, row: row)
            hintIndexLabel.position = CGPointMake(hintIndexLabel.position.x +  tileWidth/4, hintIndexLabel.position.y + tileHeight/1.65)
            hintIndexLabel.verticalAlignmentMode = .Bottom
            hintIndexLabel.fontName = "HelveuticaNeue-Bold"
            hintIndexLabel.text = "\(hintIndex)"
            hintIndexLabel.fontSize = 20
            hintIndexLabel.zPosition = 2
            hintIndexLabel.fontColor = UIColor.blackColor()
            hintIndex++
            node!.addChild(hintIndexLabel)
        }
        tileLayer.addChild(node!)
    }
    
    func updateAllTextLabels(board: Array2D<Tile>){
        for row in 0..<numRows {
            for column in 0..<numColumns {
                if let text = board[column,row]?.getText() {
                    updateLabel(column, row: row, text: text)
                }
            }
        }
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
    }

    func pointForColumn(column: Int, row: Int) -> CGPoint {
        let horizontalShift = CGFloat(numColumns) * tileWidth/2;

        return CGPoint(
            x: CGFloat(column) * tileWidth - horizontalShift,
            y: (CGFloat(row) * (-1) * tileHeight + tileHeight))
    }
    
    func returnHintsAtIndex(index: Int) -> String?{
        if let dictionary = Dictionary<String, AnyObject>.loadJSONFromBundle("CWPuzzle") {
            let hints = dictionary["hints"] as! [String]
            return hints[index]
        }
        return nil
    }
    
    //Get row and column for clicked tile
    func columnForPoint(point: CGPoint) -> (success: Bool, coloumn: Int, row: Int){
        let horizontalShift = CGFloat(numColumns) * tileWidth/2;
        let x = point.x + horizontalShift
        let y = (-1) * (point.y - 2 * tileHeight)

        print(point)
        print(x)
        print(y)
        
        if(x >= 0 &&
            x <= CGFloat(numColumns) * tileWidth &&
            y >= 0 &&
            y <= CGFloat(numRows) * tileHeight){
                print("success")
            return (true, Int(x/tileWidth),Int(y/tileHeight))
        }
        return (false, 0,0)
    }

}