//
//  PlayerAccount.swift
//  Garden
//
//  Created by 64911 on 1/20/19.
//  Copyright © 2019 64911. All rights reserved.
//

import UIKit
import SpriteKit

class PlayerAccount{

    private var accountBalance: Double
    
    private var balanceSprite : SKLabelNode
    
    private var passiveCurrencyGain: Double
    
    private var currencySprite : SKSpriteNode
    
    private var gainLabels = [SKLabelNode]()
    
    init (startingBalance: Int, coinSprite: String){
        
        accountBalance = Double(startingBalance)
        
        balanceSprite = SKLabelNode(text: "")
        
        currencySprite = SKSpriteNode(imageNamed: coinSprite)
        
        passiveCurrencyGain = 1.00
        
    }
    
    func addBalanceSprite(env: OutdoorScene){
        
        env.addChild(balanceSprite)
        balanceSprite.position = CGPoint(x: 0, y: Dimensions().screenHeight/2 - 100)
        balanceSprite.fontSize = 45
        balanceSprite.fontColor = .black
        balanceSprite.zPosition = 150
        env.addChild(currencySprite)
        currencySprite.position = CGPoint(x: balanceSprite.position.x, y: balanceSprite.position.y + 40)
        currencySprite.zPosition = balanceSprite.zPosition
    }
    func setBalance(newBalance: Int){
        
        accountBalance = Double(newBalance)
    }
    
    func balance()-> Int {
        
        return Int(accountBalance)
    }
    
    func gainPassively(){
        accountBalance = accountBalance + Double(passiveCurrencyGain)
        balanceSprite.text = formatBalance()
    }
    func gainPassively(multiplier: Double){
        accountBalance = accountBalance + Double((passiveCurrencyGain * multiplier))
        balanceSprite.text = formatBalance()
    }
    
    func gainAggresively(multiplier: Double, potPosition: CGPoint, potDimensions: CGPoint, env: OutdoorScene ){
        var gainLabel = SKLabelNode(text: "")
        let gainVar = Int(1 * multiplier)
        if (gainVar) == 1 {
          gainLabel = SKLabelNode(text: "$" + String(gainVar))
        }
        else
        {
         gainLabel = SKLabelNode(text: "$" + String(gainVar - 1))
        }
        gainLabel.fontSize = 22
        gainLabel.zPosition = 150
        gainLabel.fontName = "EuphemiaUCAS"
        gainLabel.fontColor = .green
        gainLabel.alpha = 0.6
        gainLabels.append(gainLabel)
        let randPos = Int.random(in: Int(potPosition.x) - Int(potDimensions.x/2) ..< Int(potPosition.x) + Int(potDimensions.x/2) )
        gainLabel.position = CGPoint(x: randPos, y: Int(potPosition.y + 50))
        let gainAction = SKAction.moveTo(y: gainLabel.position.y + 100 , duration: TimeInterval(2))
        let gainAction2 = SKAction.fadeOut(withDuration: TimeInterval(2))
    
        accountBalance = accountBalance + Double(gainVar)
        
        
        //Gain label animation
        env.addChild(gainLabel)
        gainLabel.run(gainAction)
        gainLabel.run(gainAction2)

        
    }
    
    func clearSprite(){
        if gainLabels.count > 0 {
        for item in 0...(gainLabels.count/2) {
            gainLabels[item].removeFromParent()
        }
        }
    }
    func forceClearSprite(){
        if gainLabels.count > 0 {
            for item in 0...(gainLabels.count - 1) {
                gainLabels[item].removeFromParent()
            }
        }
    }
    func formatBalance()-> String{
        
        
        var label = ""
        var amount = accountBalance
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
    
        
        if accountBalance > 1000 {
            balanceSprite.fontSize = 30
            label = "K"
            amount = amount / 1000
         
        }
        if accountBalance > 1000000 {
            balanceSprite.fontSize = 30
            label = "M"
            amount = amount / 1000000
           
        }
        if accountBalance > 1000000000 {
            balanceSprite.fontSize = 30
            label = "B"
            amount = amount / 1000000000
            
        }
        if accountBalance > 1000000000000 {
            balanceSprite.fontSize = 30
            label = "T"
            amount = amount / 1000000000000
  
        }
        if accountBalance > 1000000000000000 {
            balanceSprite.fontSize = 30
            label = "Q"
            amount = amount / 1000000000000000
        
        }
        let formattedAmount = formatter.string(from: amount as NSNumber)!
        return String(formattedAmount + " " + label)
        
    }
}

