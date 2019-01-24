//
//  ZenViewController.swift
//  Garden
//  ===========================================
//  a ViewController that accepts built-in Gesture Controls and uses the input to manipulate
//  the ZenGarden class.
//  ===========================================
//  Created by Josh Tschetter on 1/22/19.
//  Copyright © 2019 Josh Tschetter. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class ZenViewController: UIViewController{

    // instantiates ZenGarden class to be manipulated
    var scene2 =  ZenGarden()
    
    // accepts input from UITapGestureRecognizer to manipulate ZenGarden class
    @IBAction func menuButton(_sender: UITapGestureRecognizer){
        print("tapped")
        if ((self.scene2.Menu())){
            print(true)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "MainMenuViewController") as! MainMenuViewController
            
            self.present(resultViewController, animated:true, completion:nil)
        }
        
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("ZenViewControllerdidLoad")
        
        if let scene = GKScene(fileNamed: "ZenGarden") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! ZenGarden? {
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .resizeFill
                scene2 = sceneNode
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
        
    }
    
    
    
}
