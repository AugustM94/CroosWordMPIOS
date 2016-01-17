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
    var dataManager: DataManager!
    
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
        dataManager = DataManager()
        board = Board()
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        //Present the scene
        skView.presentScene(scene)
        skView.addSubview(scene.textLayer)
        hiddenInputTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        hiddenInputTextField.delegate = self
        hiddenInputTextField.keyboardType = UIKeyboardType.ASCIICapable
        self.view.addSubview(hiddenInputTextField)
        youWonLabel.hidden = true
        beginGame()
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
                        print("Text field became first responder")
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
        dataManager.getDataFromRemote() // move to dataManager init
        scene.createInitialTileNodes()
        scene.addSpritesForTiles(board.getTilesArray())
        scene.initializeSelectedTile()
        scene.updateAllTextLabels(board.getTilesArray())
    }
    
    
    func textFieldDidChange(textField: UITextField){
        updateMostRecentInputCharacter(textField)
        board.tileAtColumn(scene.activeColumn, row: scene.activeRow).setText(mostRecentInputCharacter)
        scene.updateLabel(scene.activeColumn, row: scene.activeRow,text: board.tileAtColumn(scene.activeColumn, row: scene.activeRow).getText())
        dataManager.parseNewUserInput(scene.activeColumn, row: scene.activeRow, value: mostRecentInputCharacter)
        if board.checkIfCrossWordComplete() {
            youWonLabel.hidden = false
        }
        
    }
    
    func updateMostRecentInputCharacter(textField: UITextField){
        let s = textField.text!
        var recentChar = s
        print(s)
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
        dataManager.getDataFromRemote()
        for row in 0..<numRows {
            for column in 0..<numColumns {
                if let text = dataManager.getRemoteTileText(column, row: row){
                    board.tileAtColumn(column, row: row).setText(text)
                    //scene.updateLabel(column, row: row, text: text)
                }
            }
        }

        //let val = board.getRemoteTileValue(column, row: row, boardContent: dataManager.getMostRecentFetch())
        //scene.updateLabel(column, row: row,text: val)
        scene.updateAllTextLabels(board.getTilesArray())
    }
    
    /*
    getters and setters
    */
    
    func getMostRecentInputCharacter() -> String{
        return mostRecentInputCharacter
    }
}


