//
//  Tutorial.swift
//  Garden
//
//  Created by 64911 on 1/23/19.
//  Copyright © 2019 64911. All rights reserved.
//

import UIKit
import SpriteKit

class Tutorial{

    
    private var Welcome = SKSpriteNode(imageNamed: "welcometogarden")
    
    private var firstInstruction = SKSpriteNode(imageNamed: "taptocontinue")
    
    private var plantASeed = SKSpriteNode(imageNamed: "plantingaseed")
    
    private var secondInstruction = SKSpriteNode(imageNamed: "dragtopot")
    
    private var tapToWater = SKSpriteNode(imageNamed: "taptowater")
    
    private var tenTimes = SKSpriteNode(imageNamed: "tentimes")
    
    private var enjoy = SKSpriteNode(imageNamed: "enjoygarden")
    
    private var InstructionsPassed = [Bool]()
    
    private var isInProgress = false
    
    private var FirstInstructionPassed = false
    
    private var counter = 0
    
    private var seedPlanted = false
    
    private var potWatered = false
    
    private var canBeWatered = false
    
    private var switchInstructions = false
    
    var allFirstInstructionActions = SKAction()
    
    var WelcomeExitOne = SKAction()
    var WelcomeExitTwo = SKAction()
    var plantSeedIntro = SKAction()
    var secondInstructionIntro = SKAction()
    
    func run(scene: OutdoorScene){
        isInProgress = true 
        
        InstructionsPassed = [FirstInstructionPassed, FirstInstructionPassed, FirstInstructionPassed, FirstInstructionPassed, FirstInstructionPassed, FirstInstructionPassed]
       
        Welcome.zPosition = 3000
        Welcome.position.y = -Dimensions().screenHeight/2 - 200
        scene.addChild(Welcome)
        Welcome.run(SKAction.moveTo(y: Dimensions().screenHeight/2 - Dimensions().screenHeight/3, duration: TimeInterval(3)))
        WelcomeExitOne = SKAction.fadeOut(withDuration: TimeInterval(2))
        WelcomeExitTwo = SKAction.moveTo(x: -1000, duration: TimeInterval(4))
      
        
        
        firstInstruction.alpha = 0.65
        firstInstruction.zPosition = 3000
        firstInstruction.position.y = -Dimensions().screenHeight/2 - 200
        scene.addChild(firstInstruction)
        firstInstruction.run(SKAction.moveTo(y: Dimensions().screenHeight/2 - Dimensions().screenHeight/3 - Welcome.size.height, duration: TimeInterval(4)))
        let firstinstructionactionone = SKAction.scale(by: 0.5, duration: TimeInterval(1))
        let firstinstructionactiontwo = SKAction.scale(by: 2, duration: TimeInterval(1))
        
        let firstInstructionActionSequence = SKAction.sequence([firstinstructionactionone, firstinstructionactiontwo])
        allFirstInstructionActions = SKAction.repeatForever(firstInstructionActionSequence)
        
        
        plantASeed.position = CGPoint(x: 400, y: Dimensions().screenHeight/2 - Dimensions().screenHeight/3)
        plantSeedIntro = SKAction.moveTo(x: 0, duration: TimeInterval(4))
        
        secondInstruction.position = CGPoint(x: 1000, y: 0)
        secondInstructionIntro = SKAction.sequence([SKAction.moveTo(y: -50, duration: TimeInterval(0)), SKAction.moveTo(x: 80, duration: TimeInterval(4))])
        
        tapToWater.position = CGPoint(x: 400, y: 100)
        tenTimes.position = CGPoint(x: 400, y: 100)
        enjoy.position = CGPoint(x: 400, y: 100)
        
        print("benchmarkthree")
        progress(scene: scene)
        
//        isInProgress = false
        
    }
    func progress(scene: OutdoorScene){
        print("tapped")
        if counter == 0 {
            firstInstruction.run(allFirstInstructionActions)
            
        }
        if counter == 1 {
            firstInstruction.removeAllActions()
            firstInstruction.run(WelcomeExitOne)
            firstInstruction.run(WelcomeExitTwo)
            Welcome.run(WelcomeExitOne)
            Welcome.run(WelcomeExitTwo)
            scene.addChild(plantASeed)
            scene.addChild(secondInstruction)
            secondInstruction.run(SKAction.sequence([secondInstructionIntro, allFirstInstructionActions]))
            plantASeed.run(plantSeedIntro)
            scene.addTutorialSeed()
        }
        if counter == 2 {
            plantASeed.run(WelcomeExitOne)
            plantASeed.run(WelcomeExitTwo)
            secondInstruction.run(WelcomeExitOne)
            secondInstruction.run(WelcomeExitTwo)
            canBeWatered = true
            if tapToWater.parent == nil {
            scene.addChild(tapToWater)
            }
            tapToWater.run(plantSeedIntro)
            if switchInstructions {
                tapToWater.run(WelcomeExitOne)
                tapToWater.run(WelcomeExitTwo)
                if tenTimes.parent == nil {
                scene.addChild(tenTimes)
                }
                tenTimes.run(plantSeedIntro)
            }
        }
        if counter == 3 {
            print("WHY")
            if(potWatered){
            tenTimes.run(WelcomeExitOne)
            tenTimes.run(WelcomeExitTwo)
            scene.addChild(enjoy)
            enjoy.run(plantSeedIntro)
            }
        }
        if counter == 4 {
            enjoy.run(WelcomeExitOne)
            enjoy.run(WelcomeExitTwo)
            isInProgress = false
        }
    }
    
    func passCurrentInstruction(scene: OutdoorScene){
        print("benchmarktwo")
        if counter == 1 {
            if seedPlanted{
              counter = counter + 1
              progress(scene: scene)
            }
        }
        else if counter == 2 {
            print("JGRSJASJDDJADK")
            if potWatered {
            print("ewfujsajkdbkjad")
            counter = counter + 1
            progress(scene: scene)
            }
            if switchInstructions{
                progress(scene: scene)
            }
        }
        else {
            counter = counter + 1
            progress(scene: scene)
        }
        
    }
    func switchInstrucs(scene: OutdoorScene){
        print("othercheck")
        switchInstructions = true
        counter = 2
        progress(scene: scene)
    }
    func inProgress()-> Bool {
        
        return self.isInProgress
    }
    func plantSeed(scene: OutdoorScene){
        seedPlanted = true
        counter = counter + 1
        progress(scene: scene)
    }
    func waterPot(scene: OutdoorScene){
        potWatered = true
        counter = counter + 1
        progress(scene: scene)
    }
    func removeFromScene(){
        counter = 0 
        Welcome.removeFromParent()
        firstInstruction.removeFromParent()
        plantASeed.removeFromParent()
        secondInstruction.removeFromParent()
        tapToWater.removeFromParent()
        tenTimes.removeFromParent()
        enjoy.removeFromParent()
    }
    func canWater()-> Bool {
        return canBeWatered
    }
    
}
