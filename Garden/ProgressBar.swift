//
//  ProgressBar.swift
//  Garden
//
//  Created by 64911 on 1/17/19.
//  Copyright © 2019 64911. All rights reserved.
//

import UIKit
import SpriteKit

class ProgressBar{
    
    private var progress : CGFloat
    private var bar : SKSpriteNode
    private var fufilledSize: Int
    var permpos : Int
    
    // SIZE DECLARED AS A CG POINT. X = WIDTH, Y = HEIGHT.
    
    //current progress is an Int 0-100, respresenting the percent of progress bar already filled.
    init(currentProgress: CGFloat, position: CGPoint, finalsize: CGPoint, barsprite: String){
        
        // progress is a variable between 0.0 and 1.0, representing the percent of progress in decimal form.
        self.progress = currentProgress/100
        
        // "bar" is a spritenode consisiting of the color or pattern of the loading bar.
        self.bar = SKSpriteNode(imageNamed: barsprite)
        
        // sets the starting length of the bar to the current progress in decimal format multiplied by the final size the progress bar should carry.
        self.bar.size.width = self.progress * finalsize.x
        
        //sets the height of the bar to specifications
        self.bar.size.height = finalsize.y
        
        // sets ZPosition of bar sprite to needed depth.
        self.bar.zPosition = 1
        
        // sets bar X and Y position to X and Y sent. Top left of bar will be at specified position.
        self.bar.position = CGPoint(x: position.x + self.bar.size.width/2, y: position.y - self.bar.size.height/2)
        
        // sets var fufilledSize to the desired "full" size of the progress bar.
        self.fufilledSize = Int(finalsize.x)
      
        self.permpos = Int(position.x)
      
    }
    
    // Function called to increment progress bar as tasks are completed
    func updateProgress(increment: CGFloat)-> Bool{
        
        // function should only run and update progress if bar is not full, or progress is less than full (1).
        if self.progress < 1{
        
        // increments the progress variable by adding the increment converted to decimal format.
        self.progress = self.progress + (increment / 100)
        
        // sets the width of the bar sprite to whatever the progress variable is multiplied by the desired final size.
        bar.size.width = (self.progress * CGFloat(fufilledSize))
        
        // corrects the extension of the width by offsetting the x position, causing the bar to appear to fill to the right.
        bar.position.x = bar.position.x + (increment/100 * CGFloat(fufilledSize)/2)
            
            return false
        }
        else {
            return true
        }
        print((self.progress * CGFloat(fufilledSize)))
    }
    
    // function called once to add the bar spritenode to a display.
    func display (env: OutdoorScene){
        
        // env is the GKScene in which the spritenode will be added.
        env.addChild(bar)
     
        
    }
    
    // called after progress bar is done being displayed
    func removeFromDisplay (){
        
        // Removes bar sprite from parent, optimization purposes.
        bar.removeFromParent()
        
    }
    
    // function will be called to manipulate bar outside of ProgressBar Class
    func getProgressBarSprite ()-> SKSpriteNode {
        
        return self.bar
    }
    
    func resetProgress(){
        
        // progress is a variable between 0.0 and 1.0, representing the percent of progress in decimal form.
        self.bar.position.x = CGFloat(permpos)
        self.progress = 0.0
        self.bar.size.width = self.progress * CGFloat(fufilledSize)
        
        
    
    }
    func run(timer: TimeInterval, position: CGPoint, potSize: CGPoint){
       
        bar.run(SKAction.moveTo(x: CGFloat(position.x - potSize.x/2), duration: timer))
        bar.run(SKAction.moveTo(y: position.y + potSize.y/2, duration: timer))
     
    }
}
