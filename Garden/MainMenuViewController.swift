//
//  MainMenuViewController.swift
//  Garden
//
//  Created by 64911 on 1/22/19.
//  Copyright © 2019 64911. All rights reserved.
//


import UIKit
import SpriteKit
import GameplayKit

class MainMenuViewController: UIViewController{
    var scene2 = MainMenu()
   
    
    @IBAction func TapRecognizer(_sender: UITapGestureRecognizer){

        print("touch recognized in viewController")
        print(self.scene2)
        print(self.scene2.Garden())
        if (self.scene2.Garden()){
            print("Aa")
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)            
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "OutdoorSceneViewController") as! OutdoorSceneViewController
            
            self.present(resultViewController, animated:true, completion:nil)
        }
        
        if (self.scene2.Zen()){
            print("Bb")
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "ZenViewController") as! ZenViewController
            
            self.present(resultViewController, animated:true, completion:nil)
        }
    
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        print("ss")
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
//        if (self.view as! SKView?) != nil {
//            print("dd")
//            self.scene? = MainMenu(fileNamed: "MainMenu")!
//            if let view = self.view as! SKView? {
//                print("ee")
//                view.presentScene(self.scene)
//                view.ignoresSiblingOrder = true
//                view.showsFPS = true
//                view.showsNodeCount = true
//            }
//        }
        
        
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
    
    
    
    
    func gardenTime(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "OutdoorSceneViewController") as! OutdoorSceneViewController
        
        self.present(resultViewController, animated:true, completion:nil)
    }
}

