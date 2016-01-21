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
    
    let hintsLabel = UILabel()
    let hiddenInputTextField = UITextField()
    
    // Variables
    private var mostRecentInputCharacter = ""
    
    @IBOutlet weak var youWonLabel: UILabel!
    @IBOutlet weak var updateBoardButton: UIButton!
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        
        //Configure view
        let skView = view as! SKView
        //Create and configure scene
 
        board = Board()
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        //Present the scene
        skView.presentScene(scene)

        hintsLabel.text = scene.returnHintsAtIndex(0)
        hintsLabel.numberOfLines = 0
        hintsLabel.frame = CGRectMake(view.frame.width/2-225, 40, 450, 400)
        hintsLabel.textColor = UIColor.blackColor()
        hintsLabel.textAlignment = .Center
        
        hiddenInputTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        hiddenInputTextField.delegate = self
        hiddenInputTextField.keyboardType = UIKeyboardType.ASCIICapable
        self.view.addSubview(hiddenInputTextField)
        self.view.addSubview(hintsLabel)
        youWonLabel.hidden = true
        beginGame()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches{
            
            
            let location = touch.locationInNode(scene.tileLayer)
            let (success, column, row) = scene.columnForPoint(location)
            if success{
                if let tile = board.tileAtColumn(column, row: row){
                    if tile.tileType == TileType.Writeable || tile.tileType == TileType.Description{
                        scene.setActiveField(column, row: row)
                        scene.moveSelectedTile(scene.spriteSelected, column: column, row: row)
                        hiddenInputTextField.becomeFirstResponder()
                    } else {
                        hiddenInputTextField.endEditing(true)
                    }
                }
            }
            else{
                hiddenInputTextField.endEditing(true)
            }
        }
    }
    
    func beginGame(){
        scene.createInitialTileNodes()
        scene.addSpritesForTiles(board.getTilesArray())
        scene.initializeSelectedTile()
        scene.updateAllTextLabels(board.getTilesArray())
    }
    
    
    func textFieldDidChange(textField: UITextField){
        updateMostRecentInputCharacter(textField)
        board.changeTileTextAtColumn(scene.activeColumn, row: scene.activeRow, text: mostRecentInputCharacter)
        scene.updateLabel(scene.activeColumn, row: scene.activeRow,text: board.tileAtColumn(scene.activeColumn, row: scene.activeRow).getText())
        
        if board.checkIfCrossWordComplete() {
            youWonLabel.hidden = false
        }
        
    }
    
    func updateMostRecentInputCharacter(textField: UITextField){
        let s = textField.text!
        var recentChar = s
        if s.characters.count > 1{
            recentChar = s.substringFromIndex(s.endIndex.advancedBy(-1)).uppercaseString
            textField.text = recentChar
        }
        mostRecentInputCharacter = recentChar
    }
    

    
    /*
    IBActions
    */

    
    @IBAction func buttonClicked(sender: AnyObject) {
        board.updateContentFromRemote()
        scene.updateAllTextLabels(board.getTilesArray())
        if board.checkIfCrossWordComplete() {
            youWonLabel.hidden = false
        }
    }
    
    /*
    getters and setters
    */
    
    func getMostRecentInputCharacter() -> String{
        return mostRecentInputCharacter
    }
}


