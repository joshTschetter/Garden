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
    
    var pipe = SKSpriteNode(imageNamed: "pipe")
    
    var pot = SKSpriteNode(imageNamed: "sproutlingplant")
    
    var menuGardenButton = SKSpriteNode(imageNamed: "menubutton")
    
    var tapped = false
    var menuButton = false
    
    override func sceneDidLoad() {
        background.position = CGPoint(x: 0, y: 0)
        background.size = CGSize(width: Dimensions().screenWidth, height: Dimensions().screenHeight)
        background.zPosition = -1
        pipe.position = CGPoint(x: 0, y: Dimensions().screenHeight/2 - 40)
        pot.position = CGPoint(x: 0, y: -Dimensions().screenHeight/2 + 100)
        menuGardenButton.position = CGPoint(x: 0 + Dimensions().screenWidth/2 - 60, y: Dimensions().screenHeight/2 - 85)
        self.addChild(pipe)
        self.addChild(pot)
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
            if pot.contains(position){
                let tapFeedbacka = SKAction.scale(by: 0.5, duration: TimeInterval(0.125))

                AudioServicesPlaySystemSound(1519)
                // run squishing animation
                pot.run(tapFeedbacka)
        
                tapped = true
            }
            
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if tapped {
            let tapFeedbackb = SKAction.scale(by: 2 , duration: TimeInterval(0.125))
            
            pot.run(tapFeedbackb)
            
            
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
    
}


