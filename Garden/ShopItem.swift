//
//  ShopItem.swift
//  Garden
//  ===========================================
//  an object that stores information needed to appear in "Shop"
//  ===========================================
//  Created by 64911 on 1/18/19.
//  Copyright © 2019 64911. All rights reserved.
//

import UIKit
import SpriteKit

class ShopItem {


    private var itemSprite : SKSpriteNode
    
    private var itemPrice : Double
    
    // itemType will always be matched with an available item for purchase
    private var itemType : String
    
    private var imageName : String
    
    private var associatedPotValue : Int
    
    init (sprite: String, type: String, price: Double){
        
        self.itemSprite = SKSpriteNode(imageNamed: sprite)
        
        self.itemPrice = price
        
        self.itemType = type
        
        self.imageName = sprite
        
        associatedPotValue = 0
        
    }
    init (sprite: String, type: String, price: Double, potLevel: Int){
        
        self.itemSprite = SKSpriteNode(imageNamed: sprite)
        
        self.itemPrice = price
        
        self.itemType = type
        
        self.imageName = sprite
        
        associatedPotValue = potLevel
        
    }
   
    func addToParent (parent: OutdoorScene){
        
        parent.addChild(self.itemSprite)
        
    }
    
    func addToParentAtPoint (parent: OutdoorScene, pos: CGPoint){
        
        parent.addChild(self.itemSprite)
        self.itemSprite.position = pos
        self.itemSprite.zPosition = 202
    }
    
    func getSprite()-> SKSpriteNode {
        
        return self.itemSprite
    }
    
    func getPrice()-> Double {
        
        return self.itemPrice
    }
    
    func getType()-> String {
        
        return itemType
    }
    
    func getImageName()-> String {
        
        return imageName
    }
    
    func getPotLevel()-> Int {
        
        return associatedPotValue
    }
    
}
