//
//  MainMenu.swift
//  Garden
//
//  Created by 64911 on 1/21/19.
//  Copyright © 2019 64911. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class MainMenu: SKScene {

    var background = SKSpriteNode(imageNamed: "mainmenubg")
    
    var mainMenuLogo = SKSpriteNode(imageNamed: "mainlogo")
    
    var myGardenButton = SKSpriteNode(imageNamed: "gardenbutton")
    
    var zenGardenButton = SKSpriteNode(imageNamed: "zenbutton")
    
    var isGoingtoGarden = false
    
    var isGoingtoZen = false
  
    override func sceneDidLoad() {
        background.position = CGPoint(x: 0, y: 0)
        background.size = CGSize(width: Dimensions().screenWidth, height: Dimensions().screenHeight)
        background.zPosition = -1
        mainMenuLogo.position = CGPoint(x: 0, y: Dimensions().screenHeight/2 - mainMenuLogo.size.height/2 - 25)
        myGardenButton.position = CGPoint(x: 0, y: mainMenuLogo.position.y - 400)
        zenGardenButton.position = CGPoint(x: 0, y: mainMenuLogo.position.y - 600)
        self.addChild(mainMenuLogo)
        self.addChild(myGardenButton)
        self.addChild(zenGardenButton)
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
            
            if myGardenButton.contains(position) {
                isGoingtoGarden = true
                print("gardenbuttonpressed")
                print(isGoingtoGarden
                )
            }
            if zenGardenButton.contains(position) {
                isGoingtoZen = true
                print("zenbuttonpressed")
            }
            print("touch registered in main menu")
            print (position)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
       
    }
    
    func zenTapCheck(pos: CGPoint)-> Bool{
      
        let tempPoint = SKSpriteNode(imageNamed: "zenbutton")
        
        let secondTempPoint = CGPoint(x: pos.x, y: pos.y)

        
        print(tempPoint)
        print(secondTempPoint)
        
        return tempPoint.contains(secondTempPoint)
        
        
    }
    func gardenTapCheck(pos: CGPoint)-> Bool {
        
        
        
        let tempPoint = SKSpriteNode(imageNamed: "gardenbutton")
        
        let secondTempPoint = CGPoint(x: pos.x, y: pos.y)

        
        print(tempPoint)
        print(secondTempPoint)
        
        return tempPoint.contains(secondTempPoint)
       
    }
    
    func Garden()-> Bool {
        return isGoingtoGarden
    }
    func Zen()-> Bool{
        return isGoingtoZen
    }

}

