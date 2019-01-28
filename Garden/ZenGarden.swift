//
//  ZenGarden.swift
//  Garden
//
//  Created by 64911 on 1/21/19.
//  Copyright © 2019 64911. All rights reserved.
//

import UIKit
import SpriteKit
import AudioToolbox

class ZenGarden: SKScene {
    var background = SKSpriteNode(imageNamed: "mainmenubg")
    
    var pipe = SKSpriteNode(imageNamed: "zenpipe")
    
    var cups = [SKSpriteNode(imageNamed: "zg"), SKSpriteNode(imageNamed: "zg1"), SKSpriteNode(imageNamed: "zg2"), SKSpriteNode(imageNamed: "zg3"), SKSpriteNode(imageNamed: "zg4"), SKSpriteNode(imageNamed: "zg5"), SKSpriteNode(imageNamed: "zg6"), SKSpriteNode(imageNamed: "zg7"), SKSpriteNode(imageNamed: "zg8"), SKSpriteNode(imageNamed: "zg9"), SKSpriteNode(imageNamed: "zg10"), SKSpriteNode(imageNamed: "zg11"), SKSpriteNode(imageNamed: "zg12"), SKSpriteNode(imageNamed: "zg13"), SKSpriteNode(imageNamed: "zg14"), SKSpriteNode(imageNamed: "zg15")]
    
    var onCup = 0
    
    var menuGardenButton = SKSpriteNode(imageNamed: "menubutton")
    
    var tapped = false
    var menuButton = false
    
    override func sceneDidLoad() {
        background.position = CGPoint(x: 0, y: 0)
        background.size = CGSize(width: Dimensions().screenWidth, height: Dimensions().screenHeight)
        background.zPosition = -1
        pipe.zPosition = 100
        pipe.position = CGPoint(x: 0, y: Dimensions().screenHeight/2 - 40)
        cups[onCup].position = CGPoint(x: 0, y: -Dimensions().screenHeight/2 + 150)
        menuGardenButton.position = CGPoint(x: 0 + Dimensions().screenWidth/2 - 60, y: Dimensions().screenHeight/2 - 85)
        self.addChild(pipe)
        self.addChild(cups[onCup])
        self.addChild(menuGardenButton)
        self.addChild(background)
        
        
        
    }
    override func didMove(to view: SKView) {
        self.scaleMode = .resizeFill
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // records touch in array as first touch
        if let touch = touches.first {
            
            // sets position of that first touch to a variable
            let position = touch.location(in: self)
            
            if menuGardenButton.contains(position){
              menuButton = true
            }
            if cups[onCup].contains(position){
                
                
                let raindrop = SKSpriteNode(imageNamed: "water")
                let waterfalling = SKAction.moveTo(y: cups[onCup].position.y - cups[onCup].size.height/2 + 50, duration: TimeInterval(1))
                let removal = SKAction.removeFromParent()
                raindrop.position = CGPoint(x: 0, y: Dimensions().screenHeight/2)
                self.addChild(raindrop)
                raindrop.run(SKAction.sequence([waterfalling, removal]))
                AudioServicesPlaySystemSound(1519)
                // run squishing animation
     
        
                tapped = true
            }
            
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if tapped {
            let removal = SKAction.removeFromParent()
            
            
            cups[onCup].run(removal)
            
            fillCup()
            
            
            tapped = false 
        }
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    func Menu()-> Bool {
        print("sjsjsjsjsjsjj")
        return menuButton
        
    }
    
    
    func fillCup(){
        
        if onCup + 1 < cups.count {
              onCup = onCup + 1
        }
        else {
            onCup = 0
        }
        cups[onCup].zPosition = 100
        cups[onCup].position = CGPoint(x: 0, y: -Dimensions().screenHeight/2 + 150)
        self.addChild(cups[onCup])
        
    }
}


