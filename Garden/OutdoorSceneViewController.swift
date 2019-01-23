//
//  OutdoorSceneViewController.swift
//  Garden
//
//  Created by 64911 on 1/22/19.
//  Copyright © 2019 64911. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class OutdoorSceneViewController: UIViewController{
    
    var scene2 = OutdoorScene()
    
    @IBAction func swipeRecognizer(_ sender: UISwipeGestureRecognizer){
      
        switch sender.direction {
        case UISwipeGestureRecognizer.Direction.left :
            print("swiped left")
            
        case UISwipeGestureRecognizer.Direction.right :
            print("swiped right")
            
        default : break
        }
        
    }
    
    @IBAction func menuButton(_sender: UITapGestureRecognizer){
      print("tapped")
        if (self.scene2.Menu()){
            print(true)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "MainMenuViewController") as! MainMenuViewController
            
            self.present(resultViewController, animated:true, completion:nil)
        }
    
    }
    
 
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
            // including entities and graphs.
            if let scene = GKScene(fileNamed: "OutdoorScene") {
                
                // Get the SKScene from the loaded GKScene
                if let sceneNode = scene.rootNode as! OutdoorScene? {
                    
                    // Set the scale mode to scale to fit the window
                    sceneNode.scaleMode = .resizeFill
                    
                    // Present the scene
                    if let view = self.view as! SKView? {
                        view.presentScene(sceneNode)
                        view.ignoresSiblingOrder = true
                        scene2 = sceneNode
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
    
  


