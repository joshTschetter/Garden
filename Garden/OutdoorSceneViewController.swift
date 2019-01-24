//
//  OutdoorSceneViewController.swift
//  Garden
//  ===========================================
//  a ViewController that accepts built-in Gesture Controls and uses the input to manipulate
//  the OutdoorScene class.
//  ===========================================
//  Created by Josh Tschetter on 1/22/19.
//  Copyright © 2019 Josh Tschetter. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class OutdoorSceneViewController: UIViewController{
    
    // instantiates the OutdoorScene to be manipulated
    var scene2 = OutdoorScene()
    
    
    // takes input from SwipeGestureRecognizer to send to OutdoorScene
    @IBAction func SwipeRecognizer(_ sender: UISwipeGestureRecognizer){
      
        // switch loop for varied output by input
        switch sender.direction {
        case UISwipeGestureRecognizer.Direction.left :
            print("swiped left")
            scene2.shiftRight(spacer: 200)
        case UISwipeGestureRecognizer.Direction.right :
            print("swiped right")
            scene2.shiftLeft(spacer: 200)
            
        default : break
            
        }
        
    }
    
    // takes input from TapGestureRecognizer to manipulate OutdoorScene
    @IBAction func pressedMenu(_sender: UITapGestureRecognizer){
        
        // if the OutdoorScene's menu button has been pressed
        if (self.scene2.Menu()){
        
            // instantiates the MainMenu ViewController to be presented
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "MainMenuViewController") as! MainMenuViewController
            
            // presents the instantiated ViewController
            self.present(resultViewController, animated:true, completion:nil)
        }
    }
 
    override func viewDidLoad() {
        
            super.viewDidLoad()
        
            print("OutdoorSceneViewControllerdidLoad")
            // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
            // including entities and graphs.
            if let scene = GKScene(fileNamed: "OutdoorScene") {
                
                // Get the SKScene from the loaded GKScene
                if let sceneNode = scene.rootNode as! OutdoorScene? {
                    
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
        
        override var shouldAutorotate: Bool {
            return false
        }
        
        override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .portrait
        }
        
        override var prefersStatusBarHidden: Bool {
            return false
        }
    }
    
  


