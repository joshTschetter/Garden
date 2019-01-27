//
//  GameScene.swift
//  Garden
//
//  Created by 64911 on 1/17/19.
//  Copyright © 2019 64911. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit
import AudioToolbox

class OutdoorScene: SKScene {
    

    // This outdoor scene should represent the first available "area" for plant cultivation.
    
    /*  Outdoor Scene should contain a few things only:
 
     Objects:
            "Plant" object - can exist in many "States", but created upon the planting of a seed. Multiple plants?
     
            "Pot" object - acts as a reciever for a "seed" object and a container for a plant object.
     
            "Seed" object - when placed within a pot will spawn a plant that is bound to that pot.
 
            Progress bars should exist so that users can visually track their progress in tasks. A progress bar should exist
                for plant growth.
     
            Running score to track the level of the plant. As the plant is watered, it grows, and can be sold/combined?
     
     
     Buttons:
     
            Shop button: creates a popup menu in which seeds and other things are available for purchase.
     
            Settings button: creates a popup menu in which basic user settings are available.
     
     Background/Animations:
     
            Animated background :
     
            Animations for actions (Watering, Plants growing, Sun rising/Setting)
 
 
   */
    
    
    // Variables
    // spriteArrays for growthPaths
    
    var onSucculent = 0
    
    // a running count of how many times that the pot has been clicked
    var touchCount = 0
    
    //initializes the dimensions for screenheight and screenwidth
    private var dimensions = Dimensions()
    
    // the background, currently provided by a spriteNode
    private var background = SKSpriteNode(imageNamed: "outdoorbg")
    private var menuButton = SKSpriteNode(imageNamed: "menubutton")
    // temporary replacement of a combination of the pot and plant objects
    private var firstPlant = Pot(sprite: "emptypot", level: 0, isPlanted: false)
    var succulentArray = ["sproutlingplant", "succulentone", "succulenttwo", "succulentthree"]
    var treeArray = ["treesproutling", "treeone", "treetwo" ]
    // the user's stored inventory
    private var potInventory = [Pot]()
    private var potInventorySpacer = 0
     var seedInventory = [Seed]()
    private var OutdoorMenu = PauseMenu()
    private var tutorial = Tutorial()
    // Creates the "Shop" for the outdoor scene
    private var outdoorStore = Shop(itemsAvailable: [ShopItem(sprite: "seed", type: "treeseed" ,price: 5000), ShopItem(sprite: "emptypot", type: "pot", price: 15000, potLevel: 0)], background: "outdoorstoreopaquebg", spriteReciever: "outdoorspritereciever", shopbg: "bgoutdoor2")
    
    // distinguishes normal gameplay from shop/tutorial/menu
    private var inStore = false
    private var inTutorial = false
    private var inMenu = false
    // Sprites unique to the Outdoor Scene
    private var shopButton = SKSpriteNode(imageNamed: "shopbutton")
    
    private var waterPipe = SKSpriteNode(imageNamed: "cloud")
    
    private var rightClicker = SKSpriteNode(imageNamed: "rightarrow")
    
    private var leftClicker = SKSpriteNode(imageNamed: "leftarrow")
    
    // Collection of variables having to do with the user
    
    // potDisplayed annotates which pot is currently centered onscreen
    private var potDisplayed = 0
    
    // player's "bank account"
    private var account = PlayerAccount(startingBalance: 0, coinSprite: "coinsprite")
    
    var secondCounter = 0
    var coinCounter = 0
    var upgradedPlant = ""
    var notfirstTimeLaunching = false
    var backtomainmenu = false
    
    var seedLinePoints = [CGPoint]()
    
    // Main function, runs once upon scene load
    override func sceneDidLoad() {
        self.addChild(waterPipe)
        waterPipe.position =  CGPoint(x: 0 , y: 0 + Dimensions().screenHeight/2 - 75)
        waterPipe.zPosition = 100
        // Loads and resaves the saved "Progress" of the player.
        
        
        touchCount = UserDefaults.standard.integer(forKey: "TapKey")
        
//        notfirstTimeLaunching = UserDefaults.standard.bool(forKey: "firstKey")
        print(notfirstTimeLaunching)
        
        // protocol for first launch
        if !notfirstTimeLaunching {
        potInventory.append(firstPlant)
        UserDefaults.standard.set(true, forKey: "firstKey")
        UserDefaults.standard.set(false , forKey: "potPlantedKey")
        UserDefaults.standard.set(0, forKey: "potLevelKey")
        UserDefaults.standard.set("", forKey: "potSpriteKey")
        UserDefaults.standard.set("", forKey: "potTypeKey")
        tutorial.run(scene: self)
        }
        
            
        // every launch after first launch
        else {
         
            
            potInventory = initializePotInventory(sA: UserDefaults.standard.array(forKey: "potSpriteKey") as! [String], lA: UserDefaults.standard.array(forKey: "potLevelKey") as! [Int], pA: UserDefaults.standard.array(forKey: "potPlantedKey") as! [Bool], tA: UserDefaults.standard.array(forKey: "potTypeKey") as! [String])
        
        }
     
        account.setBalance(newBalance: UserDefaults.standard.integer(forKey: "AccountBalance"))
        
        /////////////////////////////////////////////////////////
        
        potInventorySpacer = 200
        // adds the water progress bar to self in the display.
        var spacer = 0
        for item in potInventory {
            item.addToHomeScreen(env: self, p: CGPoint(x: CGFloat(0 + spacer * 200) , y: 0 - Dimensions().screenHeight/2 + 150), cloudPoint: waterPipe.position)
            spacer = spacer + 1
        }
        // sprite formatting
        self.addChild(background)
        background.zPosition = -2
        background.size.width = Dimensions().screenWidth
        background.size.height = Dimensions().screenHeight
        
        // adds a pause button to the screen
        self.addChild(menuButton)
         menuButton.position = CGPoint(x: 0 + Dimensions().screenWidth/2 - 60, y: Dimensions().screenHeight/2 - 85)
        self.addChild(shopButton)
        shopButton.position = CGPoint(x: 0 - Dimensions().screenWidth/2 + 60, y: Dimensions().screenHeight/2 - 85)
        
       
        
        self.addChild(rightClicker)
        rightClicker.position = CGPoint(x: 100, y: 0 - Dimensions().screenHeight/2 + 75)
        rightClicker.zPosition = 100
        
        self.addChild(leftClicker)
        leftClicker.position = CGPoint(x: -100, y: 0 - Dimensions().screenHeight/2 + 75)
        leftClicker.zPosition = 100
        account.addBalanceSprite(env: self)
        

    }
    override func didMove(to view: SKView) {
        self.scaleMode = .resizeFill
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
      
    }
    
    func touchMoved(toPoint pos : CGPoint) {
     
    }
    
    func touchUp(atPoint pos : CGPoint) {
     
    }
    
    func createSeedLine(){
        
        let path = CGMutablePath()
        path.move(to: seedLinePoints.first ?? CGPoint(x: 0, y: 0))
        
        for point in seedLinePoints {
            
            path.addLine(to: point)
            
        }
        
        let line = SKShapeNode()
        line.path = path
        line.fillColor = .clear
        line.lineWidth = 0.2
        line.strokeColor = .green
        line.lineCap = .round
        line.glowWidth = 5
        self.addChild(line)
        
        let fade : SKAction = SKAction.fadeOut(withDuration: TimeInterval(1))
        fade.timingMode = .easeIn
        let remove: SKAction = SKAction.removeFromParent()
        
        line.run(SKAction.sequence([fade, remove]))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // records touch in array as first touch
        if let touch = touches.first {
    
        // sets position of that first touch to a variable
        let position = touch.location(in: self)
            
            seedLinePoints.removeAll()
            for item in seedInventory {
                let safeArea = CGRect(x: item.getSprite().position.x , y: item.getSprite().position.y, width: item.getSprite().size.width + 40, height: item.getSprite().size.height + 40)
                if safeArea.contains(position){
                    item.click()
                    seedLinePoints.append(position)
                }
                
            }
          
            
        // if the user is in the normal gameplay screen
        
        if !inStore && !inMenu && !inTutorial{

        // if the pot currently being displayed is tapped
        if potInventory[potDisplayed].contains(p: position) && potInventory[potDisplayed].isPlanted(){
            
            account.gainAggresively(multiplier: Double(potInventory[potDisplayed].getLevel() + 1) ,potPosition: potInventory[potDisplayed].getPosition(), potDimensions: potInventory[potDisplayed].getSize(), env: self)
            
     
            if potInventory[potDisplayed].getType().contains("succulent"){
            if potInventory[potDisplayed].getLevel()/10 < succulentArray.count - 1 {
                upgradedPlant = succulentArray[potInventory[potDisplayed].getLevel()/10]
//                account.forceClearSprite()
            }
            else {
                upgradedPlant = succulentArray[succulentArray.count - 1]
            }
                
            }
                
            else if potInventory[potDisplayed].getType().contains("tree"){
            if potInventory[potDisplayed].getLevel()/10 < succulentArray.count - 1 {
                upgradedPlant = treeArray[potInventory[potDisplayed].getLevel()/10]
                //                account.forceClearSprite()
            }
            else {
                upgradedPlant = treeArray[treeArray.count - 1]
            }
            }
            // activates the touched function in the plant class and sets the level variable
            potInventory[potDisplayed] = potInventory[potDisplayed].tapped(nextUpgradeSprite: upgradedPlant, env: self, cloudPoint: waterPipe.position)
            

    
            // adds one touch to the running counter
            touchCount = touchCount + 1
        } else {
                   potInventory[potDisplayed].needToPlantSeed(scene: self)
            }
        //END OF SUCCULENT TOUCHED //
            if menuButton.contains(position){
                print("menuButtonPressed")
                inMenu = true
                OutdoorMenu.addToScene(scene: self)
            }
        // if the store button is tapped
        if shopButton.contains(position){
        print("store clicked")
        // activates the store
        outdoorStore.activateInOutdoorScene(scene: self)
        inStore = true
        }
        // END OF SHOP BUTTON TOUCHED //
            if rightClicker.contains(position){
                shiftRight(spacer: potInventorySpacer)
            }
            if leftClicker.contains(position){
                shiftLeft(spacer: potInventorySpacer)
            }
        // END OF IN NORMAL GAMEPLAY TOUCHES //
            }
        else if inMenu {
            
            if !OutdoorMenu.isMenuClicked(p: position){
                inMenu = false
                OutdoorMenu.removeFromScene()
            }
          inTutorial = OutdoorMenu.tutorialActivated(p: position)
            if inTutorial {
                  tutorial.run(scene: self)
                  inMenu = false
                  OutdoorMenu.removeFromScene()
            }
           
          backtomainmenu =  OutdoorMenu.backToMenuClicked(p: position)
            if backtomainmenu {
                inMenu = false
                OutdoorMenu.removeFromScene()
            }

        }
         else if inTutorial{
            print("benchmarkone")
            tutorial.passCurrentInstruction(scene: self)
            tutorial.exitButtonClicked(p: position, scene: self)
            if tutorial.canWater() {
                if potInventory[potDisplayed].contains(p: position) && potInventory[potDisplayed].isPlanted(){
                    
                    account.gainAggresively(multiplier: Double(potInventory[potDisplayed].getLevel() + 1) ,potPosition: potInventory[potDisplayed].getPosition(), potDimensions: potInventory[potDisplayed].getSize(), env: self)
                    print(potInventory[potDisplayed].getLevel())
                    if potInventory[potDisplayed].getLevel() == 2 {
                        print("okay")
                        tutorial.switchInstrucs(scene: self)
                    }
                    if potInventory[potDisplayed].getLevel()/10 < succulentArray.count - 1 {
                        upgradedPlant = succulentArray[potInventory[potDisplayed].getLevel()/10]
                        if potInventory[potDisplayed].getLevel() % 10 == 0 && potInventory[potDisplayed].getLevel() != 0 {
                            print("WHAT")
                        tutorial.waterPot(scene: self)
                        }
                        //                account.forceClearSprite()
                    }
                    else {
                        upgradedPlant = succulentArray[succulentArray.count - 1]
                    }
                    // activates the touched function in the plant class and sets the level variable
                    potInventory[potDisplayed] = potInventory[potDisplayed].tapped(nextUpgradeSprite: upgradedPlant, env: self, cloudPoint: waterPipe.position)
                    
                    
                    
                    // adds one touch to the running counter
                    touchCount = touchCount + 1
                }
            }
            if !tutorial.inProgress(){
                tutorial.removeFromScene(scene: self)
                inTutorial = false 
            }
        }
        // touches recorded in the shop
        else if inStore{
                // runs a checker to see if the shop will be exited with the touch
                if outdoorStore.didExitShop(p: position) {
                    // shop deactivation sequence
                    outdoorStore.deactivate()
                    inStore = false
                }
            if outdoorStore.potPurchaseCheck(touch: position, currentBalance: Double(account.balance())).purchasedPot.isReal(){
                potInventory.append(outdoorStore.potPurchaseCheck(touch: position, currentBalance: Double(account.balance())).purchasedPot)
                account.setBalance(newBalance: Int(outdoorStore.potPurchaseCheck(touch: position, currentBalance: Double(account.balance())).newAccountBalance))
                potInventory[potInventory.count-1].addToHomeScreen(env: self, p: CGPoint(x: potInventory[potInventory.count - 2].getPosition().x + CGFloat(potInventorySpacer), y: 0 - Dimensions().screenHeight/2 + 150) , cloudPoint: waterPipe.position)
                
                outdoorStore.deactivate()
                inStore = false
                
            }
            if outdoorStore.seedPurchaseCheck(touch: position, currentBalance: Double(account.balance())).purchasedSeed.isReal(){
                seedInventory.append(outdoorStore.seedPurchaseCheck(touch: position, currentBalance: Double(account.balance())).purchasedSeed)
                account.setBalance(newBalance: Int(outdoorStore.seedPurchaseCheck(touch: position, currentBalance: Double(account.balance())).newAccountBalance))
                seedInventory[seedInventory.count-1].addToHomeScreen(env: self, pos: CGPoint(x: 0, y: 0))
                outdoorStore.deactivate()
                inStore = false
            }
            // END OF TOUCHES IN SHOP //
            }
    // TOUCH ARRAY FIRST ENDING //
    }
    // END OF TOUCHES BEGAN //
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self)
            for item in seedInventory {
                if item.isClicked(){
                    item.getSprite().position = position
                    seedLinePoints.append(position)
                    createSeedLine()
                }
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      UserDefaults.standard.set(touchCount, forKey: "MyKey")
        if let touch = touches.first {
            let position = touch.location(in: self)
         
            var counter = 0
            for item in seedInventory{
                if potInventory[potDisplayed].getPotSprite().contains(item.getSprite().position) && item.isClicked(){
                    potInventory[potDisplayed].plant(withSeed: item)
                    item.plant(display: self)
                    seedInventory.remove(at: counter)
                    
                    if inTutorial {
                        tutorial.plantSeed(scene: self)
                    }
                }
                else {
                 item.shinyNewSeed(scene: self)
                }
                counter = counter + 1
            }
            
        
        
        
        // if you aren't in the store, this serves animation purposes
       
        if !inStore {
     potInventory[potDisplayed].released()
  
            if coinCounter % 50 == 0 {
        account.clearSprite()
            }
        coinCounter = coinCounter + 1
        }
   
    }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
       
       
       inTutorial =  tutorial.inProgress()
       UserDefaults.standard.set(account.balance(), forKey: "AccountBalance")
       UserDefaults.standard.set(savePotInventory().plantedArray, forKey: "potPlantedKey")
       
        if secondCounter % 50 == 0 {
            
            account.gainPassively()
            UserDefaults.standard.set(savePotInventory().spriteArray, forKey: "potSpriteKey")
            UserDefaults.standard.set(savePotInventory().typeArray, forKey: "potTypeKey")
            UserDefaults.standard.set(savePotInventory().levelArray, forKey: "potLevelKey")
            
        }
        
        
        secondCounter = secondCounter + 1
    }
    
    func shiftRight(spacer: Int){
      
        print(potDisplayed)
        if actionDone(){
        if potInventory.count > 1{
        if potDisplayed < potInventory.count-1 {
            for item in potInventory {
                item.clearfeed()
                let destination = Int(item.getPosition().x) - spacer
                let timer = TimeInterval(0.5)
                let moveAction = SKAction.moveTo(x: CGFloat(destination), duration: timer)
                item.run(action: moveAction, time: timer )
            }
            potDisplayed = potDisplayed + 1
        }
        }
    }
    }
    func shiftLeft(spacer: Int){
       
        if actionDone() {
        if potInventory.count > 1 {
        if potDisplayed > 0 {
        for item in potInventory{
            item.clearfeed()
            for item in potInventory {
                let destination = Int(item.getPosition().x) + spacer
                let timer = TimeInterval(0.5)
                let moveAction = SKAction.moveTo(x: CGFloat(destination), duration: timer)
                item.run(action: moveAction, time: timer)
            }
        }
        potDisplayed = potDisplayed - 1
        }
        }
    }
    }
    
    func actionDone()-> Bool {

        for item in potInventory {
            if item.getPosition().x == 0 {
                return true
            }
        }
        return false
    }
    func Menu()-> Bool {
     
        return backtomainmenu
        
    }
    func getPotInventory()-> [Pot]{
    return potInventory
    }
    
    func savePotInventory()-> (spriteArray: [String], levelArray: [Int], plantedArray: [Bool], typeArray: [String]){
        var sA = [String]()
        var lA = [Int]()
        var pA = [Bool]()
        var tA = [String]()
        for item in potInventory{
            sA.append(item.formatForSave().sprite)
            lA.append(item.formatForSave().level)
            pA.append(item.formatForSave().isPlanted)
            tA.append(item.formatForSave().type)
            
        }
        return (sA, lA, pA, tA)
    }
    
    func initializePotInventory(sA: [String], lA: [Int], pA: [Bool], tA: [String])-> [Pot]{
        
        var counter = 0
        var lazyPotArray = [Pot]()
        for item in sA {
            let lazyPot = Pot(sprite: item, level: lA[counter], isPlanted: pA[counter])
            if lA[counter] > 0 {
             lazyPot.plant(withSeed: tA[counter])
            }
            lazyPotArray.append(lazyPot)
            
            counter = counter  + 1
        }
        return lazyPotArray
    }
    
    func addTutorialSeed(){
        seedInventory.append(Seed(sprite: "seed", type: "succulent"))
        seedInventory[seedInventory.count - 1].addToHomeScreen(env: self, pos: CGPoint(x: 0, y: -1000))
        seedInventory[seedInventory.count - 1].shinyNewSeed(scene: self)
    }

}
