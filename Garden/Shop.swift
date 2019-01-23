//
//  Shop.swift
//  Garden
//
//  Created by 64911 on 1/18/19.
//  Copyright © 2019 64911. All rights reserved.
//

import UIKit
import SpriteKit

class Shop {
    
    // a spriteNode that serves as the background of the shop enviornment.
    private var shopBackground : SKSpriteNode
    private var shopEnviornment : SKSpriteNode
    private var exitButton : SKSpriteNode
    
    // an array of Shop Items that each will represent an item available for sale in the shop.
    private var itemsForSale : [ShopItem]
    
    // an array of sprites that the Shop Items will sit on top of, sort of formatting the shop.
    private var itemRecieverSprites : [SKSpriteNode]
    
    private var priceLabels : [SKLabelNode]
    // variables to control where the top item for sale will spawn
    private var shopItemStartingHeight : Int
    private var shopItemOffsetDistance : Int

    // Basic shop initializer
    init (itemsAvailable: [ShopItem] , background: String , spriteReciever: String, shopbg: String){
        
        // initializes the shopItem array.
        itemsForSale = [ShopItem]()
        
        // initializes the reciever sprites array.
        itemRecieverSprites = [SKSpriteNode]()
        
        priceLabels = [SKLabelNode]()
        // traverses the "items available" constructor array and transfers content into the "items for sale" array, and also adds one spriteReciever for every sprite sent.
        for item in itemsAvailable {
            itemsForSale.append(item)
            priceLabels.append(SKLabelNode(text: "$ " + String(item.getPrice())))
            itemRecieverSprites.append(SKSpriteNode(imageNamed: spriteReciever))
        }
        
        // sets the shop background to constructor-specified image
        shopBackground = SKSpriteNode(imageNamed: background)
        shopEnviornment = SKSpriteNode(imageNamed: shopbg)
        exitButton = SKSpriteNode(imageNamed: "exitshop")
        
        
        shopItemStartingHeight = 250
        shopItemOffsetDistance = 150
    
    }
    
    // function called when "shop" button is clicked
    func activateInOutdoorScene(scene: OutdoorScene){
        
        // formatting the background to the screen size
        scene.addChild(shopBackground)
        shopBackground.size.width = Dimensions().screenWidth
        shopBackground.size.height = Dimensions().screenHeight
        shopBackground.zPosition = 199
        
        scene.addChild(shopEnviornment)
        shopEnviornment.position = CGPoint(x: 0, y: 0 - shopEnviornment.size.height/2 + 400)
        shopEnviornment.zPosition = 200
        
        scene.addChild(exitButton)
        exitButton.position = CGPoint(x: 0 - shopEnviornment.size.width/2, y: shopEnviornment.position.y + shopEnviornment.size.height/2 - 50)
        exitButton.zPosition = 210
        // traverses the itemRecieverSprites array, which will always be the same length as the itemsForSale array, and adds them and the items for sale to the screen proportionally. The counter serves for proportionate distance.
        
        
        
        var counter = 0
        
        for item in itemRecieverSprites {
            
            // adds both the reciever and the item Sprites based on how many are in the array
            scene.addChild(item)
            item.position = CGPoint(x: -60, y: counter * -shopItemOffsetDistance + shopItemStartingHeight)
            item.zPosition = 201
            itemsForSale[counter].addToParentAtPoint(parent: scene, pos: CGPoint(x: Int(item.position.x) , y: counter * -shopItemOffsetDistance + shopItemStartingHeight))
            itemsForSale[counter].getSprite().size = item.size
            scene.addChild(priceLabels[counter])
            priceLabels[counter].position = CGPoint(x: 65 , y: counter * -shopItemOffsetDistance + shopItemStartingHeight - 15)
            priceLabels[counter].zPosition = 210
            
            //
            
            counter = counter + 1
        }
        
        
        
    }
    
    // function called when "exit" button is clicked
    func deactivate(){
        
        var counter = 0
        
        for item in itemRecieverSprites {
    
        item.removeFromParent()
            
        itemsForSale[counter].getSprite().removeFromParent()
        priceLabels[counter].removeFromParent()
        
        counter = counter + 1
            
        }
        
        shopBackground.removeFromParent()
        shopEnviornment.removeFromParent()
        exitButton.removeFromParent()
    }
    
    func didExitShop (p: CGPoint)-> Bool {
        
        return (shopBackground.contains(p) && !shopEnviornment.contains(p)) || exitButton.contains(p)
        
        
    }
    
    func scrollDownInShop (increment: CGFloat){
        
        
        
        
    }
    
    func potPurchaseCheck (touch: CGPoint, currentBalance: Double)-> (purchasedPot: Pot, newAccountBalance: Double) {
        
        let fakePot = Pot(isFake: true)
        
        for item in itemsForSale {
            if item.getSprite().contains(touch){
                if item.getPrice() < currentBalance {
                if item.getType() == "pot" {
                    return (Pot(sprite: item.getImageName(), level: item.getPotLevel()), currentBalance - item.getPrice())
                    
                }
                }
            }
            
        }
        return (fakePot, currentBalance)
        
    }
    func seedPurchaseCheck (touch: CGPoint, currentBalance: Double)-> (purchasedSeed: Seed , newAccountBalance: Double) {
        let fakeSeed = Seed(fake: true)
        for item in itemsForSale {
            if item.getSprite().contains(touch){
                if item.getPrice() < currentBalance{
                if item.getType() == "seed" {
                    return (Seed(sprite: item.getImageName()), currentBalance - item.getPrice())
                }
                }
            }
            
        }
        
        return (fakeSeed, currentBalance)
    }
}
