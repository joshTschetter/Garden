//
//  PauseMenu.swift
//  Garden
//
//  Created by 64911 on 1/23/19.
//  Copyright © 2019 64911. All rights reserved.
//

import UIKit
import SpriteKit

class PauseMenu{

    private var PauseMenu = SKSpriteNode(imageNamed: "gardenpausemenu")
    
    private var MainMenuButton = SKSpriteNode(imageNamed: "returntomainmenu")
    

    
    func addToScene(scene: OutdoorScene){
        
        PauseMenu.zPosition = 10000000
        PauseMenu.position = CGPoint(x: 0, y: 0)
        scene.addChild(PauseMenu)
        
        MainMenuButton.zPosition = 100100000
        MainMenuButton.position = CGPoint(x: 0 , y: PauseMenu.position.y - PauseMenu.size.height/4)
        scene.addChild(MainMenuButton)
        

    }
    
    func removeFromScene(){
        PauseMenu.removeFromParent()
        MainMenuButton.removeFromParent()

        
    }
    func isMenuClicked(p: CGPoint)-> Bool {
        return PauseMenu.contains(p)
    }
    func backToMenuClicked(p: CGPoint)-> Bool{
        return MainMenuButton.contains(p)
    }
    
}
