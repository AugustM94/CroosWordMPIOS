//
//  GameViewController.swift
//  crosswords
//
//  Created by August Møbius on 07/01/16.
//  Copyright © 2016 drades. All rights reserved.
//
import UIKit
import SpriteKit

class GameViewController: UIViewController, UITextFieldDelegate {
    var scene: GameScene!
    var board: Board!
    
    let textField = UITextField()
    
    @IBOutlet weak var youWonLabel: UILabel!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        //Configure view
        let skView = view as! SKView
        
        //Create and configure scene
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        board = Board()
        scene.board = board
        
        beginGame()
        //Present the scene
        skView.presentScene(scene)
        skView.addSubview(scene.textLayer)
        textField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        textField.delegate = self
        textField.keyboardType = UIKeyboardType.ASCIICapable
        self.view.addSubview(textField)
        
        youWonLabel.hidden = true
    }
    
    
    func beginGame(){
        board.createInitialTiles()
        scene.createInitialTileNodes()
        let tiles = board.getTilesArray()
        scene.addSpritesForTiles(tiles)
        scene.initializeSelectedTile()
        scene.updateLabel(0, row: 0)
        
    }
    
    
    func textFieldDidChange(textField: UITextField){
        
        let s = textField.text!
        var recentChar = s
        print(s)
        if s.characters.count > 1{
            recentChar = s.substringFromIndex(s.endIndex.advancedBy(-1)).uppercaseString
            textField.text = recentChar
        }
        board.tileAtColumn(scene.activeColumn, row: scene.activeRow).text = recentChar
        scene.updateLabel(scene.activeColumn, row: scene.activeRow)
        if board.checkIfCrossWordComplete() {
            youWonLabel.hidden = false
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches{
            let location = touch.locationInNode(scene.tileLayer)
            let (success, column, row) = scene.columnForPoint(location)
            if success{
                
                
                if let tile = board.tileAtColumn(column, row: row){
                    if tile.tileType == TileType.Writeable {
                        scene.setActiveField(column, row: row)
                        scene.moveSelectedTile(scene.spriteSelected, column: column, row: row)
                        textField.becomeFirstResponder()
                    } else {
                        textField.endEditing(true)
                    }
                }
            }
            else{
                textField.endEditing(true)
            }
        }
    }
    
}


