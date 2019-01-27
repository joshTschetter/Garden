//
//  Seed.swift
//  Garden
//
//  Created by 64911 on 1/18/19.
//  Copyright © 2019 64911. All rights reserved.
//

import UIKit
import SpriteKit

class Seed{

    private var seedSprite: SKSpriteNode
    
    private var spriteName: String
    
    private var seedisReal : Bool
    
    private var seedType : String
    
    var clicked = false
    
    init (sprite: String, type: String) {
        
        seedSprite = SKSpriteNode(imageNamed: sprite)
        spriteName = sprite
        seedisReal = true
        seedType = type
    }
    
    init(fake: Bool){
        seedSprite = SKSpriteNode(imageNamed: "")
        spriteName = ""
        seedisReal = false
        seedType = "" 
    }
    
    func getSpriteName()-> String {
        
        return spriteName
    }
    func isReal()-> Bool {
        return seedisReal
    }
    
    func addToHomeScreen(env: OutdoorScene, pos: CGPoint){
        
        env.addChild(seedSprite)
        seedSprite.position = pos
        shinyNewSeed(scene: env)
    }
    
    func getSprite()-> SKSpriteNode {
        return seedSprite
    }
    func click(){
        self.clicked = true
        seedSprite.removeAllActions()
    }
    func isClicked()-> Bool {
        return clicked
    }
    func unClick(){
        self.clicked = false
    }
    
    func plant(display: OutdoorScene){
        let actionOne = SKAction.colorize(with: .green, colorBlendFactor: 5, duration: (1))
        let actionTwo = SKAction.fadeOut(withDuration: TimeInterval(1))
        let actionThree = SKAction.scale(by: 3, duration: TimeInterval(1))
        let tempNode = seedSprite.copy() as! SKSpriteNode
        let tempTextNode = SKLabelNode(text: "NEW PLANT")
        let labelactionone = SKAction.moveTo(y: 0, duration: TimeInterval(5))
        let labelactiontwo = SKAction.fadeOut(withDuration: TimeInterval(10))
        tempTextNode.position = seedSprite.position
        tempTextNode.fontName = "EuphemiaUCAS-Bold"
        tempTextNode.fontSize = 45
        tempTextNode.fontColor = .green
        tempNode.zPosition = 3000
        tempTextNode.zPosition = 3000
        tempNode.run(actionOne)
        tempNode.run(actionTwo)
        tempNode.run(actionThree)
        tempTextNode.run(labelactionone)
        tempTextNode.run(labelactiontwo)
        seedSprite.removeFromParent()
        display.addChild(tempNode)
        display.addChild(tempTextNode)
        
    }
    
    func shinyNewSeed(scene: OutdoorScene){
        let SEEDDROP = SKAction.moveTo(y: -100, duration: TimeInterval(2))
        let tantalizingone = SKAction.scale(by: 0.75, duration: TimeInterval(2))
        let tantalizingtwo = SKAction.scale(by: 1.3333333333333333333, duration: TimeInterval(2))
        let tantalizingAction = SKAction.sequence([tantalizingone, tantalizingtwo])
        seedSprite.run(SEEDDROP)
        seedSprite.run(SKAction.repeatForever(tantalizingAction))
        
    }
    
    func getType()-> String {
        
        return seedType
    }
}
