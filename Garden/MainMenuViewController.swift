//
//  MainMenuViewController.swift
//  Garden
//  ============================================
//  A ViewController that accepts built-in Gesture Controls and uses the input to manipulate
//  the MainMenu class.
//  =============================================
//  Created by Josh Tschetter on 1/22/19.
//  Copyright © 2019 Josh Tschetter. All rights reserved.
//


import UIKit
import SpriteKit
import GameplayKit

class MainMenuViewController: UIViewController{
    
    // instantiates MainMenu Scene to be manipulated
    var scene2 = MainMenu()
   
    
    
    // a tap gesture recognizer to manipulate MainMenu class
    @IBAction func TapRecognizer(_sender: UITapGestureRecognizer){

        print("touch recognized in MainMenuviewController")
      
        // checks to see if the garden button within the scene has been pressed
        if (self.scene2.Garden()){
            
            print("Garden ViewController Presented")
            
            // instantiates a new ViewController initialized as the OutDoorScene
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)            
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "OutdoorSceneViewController") as! OutdoorSceneViewController
            
            // presents the newly created ViewController
            self.present(resultViewController, animated:true, completion:nil)
        }
        
        // checks to see if the zen button within the scene has been pressed
        if (self.scene2.Zen()){
            
            print("Zen ViewController Presented")
            
            // instantiates a new ViewController initialized as the ZenScene
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "ZenViewController") as! ZenViewController
            
            // presents the newly created ViewController
            self.present(resultViewController, animated:true, completion:nil)
        }
    
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        print("MainMenu viewDidLoad")
        
        if let scene = GKScene(fileNamed: "MainMenu") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! MainMenu? {
                
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

