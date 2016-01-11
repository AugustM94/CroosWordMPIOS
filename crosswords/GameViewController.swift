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
        
        
        //var arrayTest = Array<Array<Tile>>()

        
        
    }
    
    
    func beginGame(){
        let tiles: Set<Tile> = board.createInitialTiles()
        scene.addSpritesForTiles(tiles)
        scene.addTextFieldForTiles(tiles)
        scene.initializeSelectedTile()
        
        for tile in tiles {
            tile.textField!.delegate = self
            tile.textField?.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
            self.view.addSubview(tile.textField!)
        }
        
    }
    
    func textFieldDidChange(textField: UITextField){
        var s = textField.text!
        if s.characters.count > 1{
            
            textField.text = s.substringFromIndex(s.endIndex.advancedBy(-1))

        } else {
            print("Longer than one")
        }
    }
    
}

