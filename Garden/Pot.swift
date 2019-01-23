//
//  Pot.swift
//  Garden
//
//  Created by 64911 on 1/18/19.
//  Copyright © 2019 64911. All rights reserved.
//

import UIKit
import SpriteKit
import AudioToolbox
class Pot  {
    // the spriteNode that represents the pot.
    private var potSprite : SKSpriteNode
    
    // variable that stores the Width value of the pot as the x value and the height value as the y value.
    private var potSize : CGPoint
    
    // array of identical sprites that serve as a visual representation of the plants being watered/fed.
    private var food : [SKSpriteNode]
    
    // variable serves as a way to differentiate the food spriteNodes coming down.
    var oneonly = true
    
    // stores the level of this pot/plant combination, and a labelNode to display the level on the pot
    private var potLevel : Int
    private var potLevelLabel : SKLabelNode
    private var potLevelProgressBar : ProgressBar

    
    private var planted = false 
    
    
    private var spriteStringName = ""
    private var potisReal : Bool
    
    init (sprite: String, level: Int ){
        
        
        // sets the pot sprite as the image sent by the constructor.
        self.potSprite = SKSpriteNode(imageNamed: sprite)
        self.spriteStringName = sprite
        // stores the size of the pot using the given image size.
        self.potSize = CGPoint(x: self.potSprite.size.width, y: self.potSprite.size.height)
        
        // initializes an array of several spritenodes that will be used to represent progress.
        self.food = [SKSpriteNode(imageNamed: "water"), SKSpriteNode(imageNamed: "water"),SKSpriteNode(imageNamed: "water"),SKSpriteNode(imageNamed: "water"),SKSpriteNode(imageNamed: "water"),SKSpriteNode(imageNamed: "water"),SKSpriteNode(imageNamed: "water"),SKSpriteNode(imageNamed: "water"),SKSpriteNode(imageNamed: "water"),SKSpriteNode(imageNamed: "water"),SKSpriteNode(imageNamed: "water"),SKSpriteNode(imageNamed: "water"),SKSpriteNode(imageNamed: "water"),SKSpriteNode(imageNamed: "water"),SKSpriteNode(imageNamed: "water"),SKSpriteNode(imageNamed: "water"),SKSpriteNode(imageNamed: "water"),SKSpriteNode(imageNamed: "water"),SKSpriteNode(imageNamed: "water"),SKSpriteNode(imageNamed: "water"),SKSpriteNode(imageNamed: "water"),SKSpriteNode(imageNamed: "water"),SKSpriteNode(imageNamed: "water"),SKSpriteNode(imageNamed: "water")]
        
        
        self.potLevel = level
        self.potLevelLabel = SKLabelNode(text: String(potLevel))
        
        self.potLevelProgressBar = ProgressBar(currentProgress: 0, position: CGPoint(x: potSprite.position.x - potSize.x/2, y: potSprite.position.y + potSize.y/2 + 150), finalsize: CGPoint(x: potSize.x, y: 30), barsprite: "opaquebar")
        
        self.potisReal = true
        
    }
    
    init(isFake: Bool){
        // sets the pot sprite as the image sent by the constructor.
        self.potSprite = SKSpriteNode(imageNamed: "")
        
        // stores the size of the pot using the given image size.
        self.potSize = CGPoint(x: self.potSprite.size.width, y: self.potSprite.size.height)
        
        // initializes an array of several spritenodes that will be used to represent progress.
        self.food = [SKSpriteNode]()
        
        
        self.potLevel = 0
        self.potLevelLabel = SKLabelNode(text: String(potLevel))
        
        self.potLevelProgressBar = ProgressBar(currentProgress: 0, position: CGPoint(x: potSprite.position.x - potSize.x/2, y: potSprite.position.y + potSize.y/2 + 150), finalsize: CGPoint(x: potSize.x, y: 30), barsprite: "opaquebar")
        
        
        self.potisReal = false
    }
    
    // adds all the sprites contained within the pot class to the Outdoor Scene.
    func addToHomeScreen (env: OutdoorScene, p: CGPoint, cloudPoint: CGPoint){
         let smoother = SKAction.fadeIn(withDuration: TimeInterval(1))
        // adds the pot Sprite to the Outdoor Scene and properly positions it.
        potSprite.run(smoother)
        env.addChild(potSprite)
        potSprite.position = p
        potSprite.zPosition = 20
        
        
        // traverses the array of "Food" spriteNodes and positions them and adds them to the Outdoor Scene.
        for item in food {
            env.addChild(item)
            let random = Int.random(in: Int(cloudPoint.x - 40) ..< Int(cloudPoint.x+40))
            item.position = CGPoint(x: CGFloat(random), y: cloudPoint.y)
            item.zPosition = 3
        }
        
        // adds the labelNode
        env.addChild(potLevelLabel)
        potLevelLabel.position = CGPoint(x: potSprite.position.x, y: potSprite.position.y - potSize.y/4)
        potLevelLabel.zPosition = 50
        potLevelLabel.fontSize = 45
        potLevelLabel.fontColor = .cyan
        potLevelLabel.fontName = "EuphemiaUCAS-Bold"
        
        env.addChild(potLevelProgressBar.getProgressBarSprite())
        potLevelProgressBar.getProgressBarSprite().position = CGPoint(x: potSprite.position.x - potSize.x/2, y: potSprite.position.y + potSize.y/2 + 30)
    }
    
    // used to determine whether pot/plant combination will be tapped.
    func contains (p: CGPoint)-> Bool {
        // either the plantSprite or potSprite can be clicked to return a true value.
        return potSprite.contains(p)
    }
    
    // if the pot is tapped, this function will be called
    func tapped (nextUpgradeSprite: String, env: OutdoorScene, cloudPoint: CGPoint)-> Pot{
        
        
        // runs the animation of the plant being watered/fed.
        feed(cloudPoint: cloudPoint)
        
        // sets the var value to true to ensure that only one food/water sprite is travelling at a time.
        oneonly = true
        
        // squishing animation
        let tapFeedbacka = SKAction.resize(toWidth: potSprite.size.width - 30 , duration: 0.125)
        let tapFeedbackb = SKAction.resize(toHeight: potSprite.size.height - 30 , duration: 0.125)
        AudioServicesPlaySystemSound(1519)
        // run squishing animation
        potSprite.run(tapFeedbacka)
        potSprite.run(tapFeedbackb)

        return growifCan(potSprite: nextUpgradeSprite, env: env, loc: self.potSprite.position, cloudPoint: cloudPoint)
    }
    
    // the inverse of the tapped function
    func released (){
        // inverse of the squishing animation, uses a saved constant variable to return the sprite to it's original size
        let tapFeedbacka = SKAction.resize(toWidth: CGFloat(potSize.x) , duration: 0.125)
        let tapFeedbackb = SKAction.resize(toHeight: CGFloat(potSize.y) , duration: 0.125)
       
        // inverse squishing animation
        potSprite.run(tapFeedbacka)
        potSprite.run(tapFeedbackb)

    }
    
    // the function used to give a visual representation of the plant being fed/watered
    func feed(cloudPoint: CGPoint){
        print(cloudPoint.y)
        // the animation used to move the spriteNodes
        let feed = SKAction.moveTo(y: potSprite.position.y , duration: TimeInterval(1))
        let feed2 = SKAction.moveTo(y: potSprite.position.x , duration: TimeInterval(1))
        let scaler = SKAction.scale(by: 0.25, duration: TimeInterval(0.2))
        let scaler2 = SKAction.scale(by: 4, duration: TimeInterval(0.2))
        let hider = SKAction.fadeOut(withDuration: TimeInterval(1.5))
        let revealer = SKAction.fadeIn(withDuration: TimeInterval(1))
        // traverses the array of identical spriteNodes
        for item in food {
            // if statement prevents the sprites from moving in groups
            if oneonly{
            
            // if the sprite is waiting in the "queue"
            if item.position.y == cloudPoint.y  {
                
                // runs the feeding animation
                item.run(scaler)
                item.run(hider)
                item.run(feed2)
                item.run(feed)
                item.run(revealer)
                item.run(scaler2)
                print(potSprite.position)
                // sets the "one only" variable to only allow the one sprite through
                oneonly = false
            }

            }
            // when the sprite reaches its destination, it will be reset into the queue
            if item.position.y <= potSprite.position.y{
                
                // puts the sprite back into the queue
                item.position.y = cloudPoint.y
            }
        }
    }
    func clearfeed(){
        for item in food {
            if item.position.y != -100000 {
                
                // puts the sprite back into the queue
                item.position.y = -1000000
            }
        }
    }
    func growifCan(potSprite: String, env: OutdoorScene, loc: CGPoint, cloudPoint: CGPoint)-> Pot {
        if potLevelProgressBar.updateProgress(increment: 5){
            potLevelProgressBar.resetProgress()

            self.potLevel = potLevel + 1
            self.potLevelLabel.text = String(potLevel)

            if potLevel % 10 == 0 {
            return upgradePot(potSprite: potSprite, display: env, cloudPoint: cloudPoint)
            }
            
            return self
        }
        else {
            return self
        }
    }
    
    func upgradePot(potSprite: String, display: OutdoorScene, cloudPoint: CGPoint)-> Pot{
        let newPot = Pot(sprite: potSprite, level: self.potLevel)
        levelUpAnimation(display: display)
       
        //proportionally positions taking into account image height gain

        newPot.addToHomeScreen(env: display, p: CGPoint(x: self.potSprite.position.x, y: self.potSprite.position.y + (newPot.potSize.y - self.potSize.y)/2), cloudPoint: cloudPoint)
        newPot.plant()
        self.potSprite.removeFromParent()
        self.potLevelLabel.removeFromParent()
        for item in self.food {
            item.removeFromParent()
        }
        return newPot
    }
    func getPotSprite()-> SKSpriteNode {
        return self.potSprite
    }
    func getLevel()-> Int {
        return potLevel
    }
    func getPosition()-> CGPoint {
        return potSprite.position
    }
    func getSize()-> CGPoint {
        return potSize 
    }
    
    func isReal()-> Bool {
        return potisReal
    }
    
    func run (action: SKAction, time: TimeInterval){
        
        self.potSprite.run(action)
        self.potLevelLabel.run(action)
        self.potLevelProgressBar.resetProgress()
    }
    
    func formatForSave()-> (sprite: String, level: Int){
        print (spriteStringName, potLevel)
        return (spriteStringName, potLevel)
    }
    
    func plant(){
        planted = true
    }
    func isPlanted()-> Bool{
        return planted 
    }
    func levelUpAnimation(display: OutdoorScene){
        
        let actionOne = SKAction.colorize(with: .green, colorBlendFactor: 0, duration: (1))
        let actionTwo = SKAction.fadeOut(withDuration: TimeInterval(1))
        let actionThree = SKAction.scale(by: 3, duration: TimeInterval(1))
        let tempNode = self.getPotSprite().copy() as! SKSpriteNode
        let tempTextNode = SKLabelNode(text: "NEW PLANT")
        let labelactionone = SKAction.moveTo(y: 0, duration: TimeInterval(5))
        let labelactiontwo = SKAction.fadeOut(withDuration: TimeInterval(10))
        tempTextNode.position = self.getPosition()
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
        display.addChild(tempNode)
        display.addChild(tempTextNode)

        
    }
}
