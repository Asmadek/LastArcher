//
//  GameViewController.swift
//  LastArcher
//
//  Created by Alexander Makhnyov on 22.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    @IBOutlet weak var scores: UILabel!
    @IBOutlet weak var accuracy: UILabel!
    @IBOutlet weak var shoots: UILabel!
    
    @IBOutlet weak var resultTextView: UITextView!
    @IBOutlet weak var menuBtn: UIButton!
    
    var skin: Int!
    var weapon: Int!
    var level: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        
        if self.level == nil {
            self.level = "Level1"
        }
        
        if let scene = GameScene.level(levelName: level) {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
          //  skView.showsPhysics = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = false
            
            if weapon == nil {
                weapon = 0
            }
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            scene.setWeapon(weapon: weapon)
            scene.scoreLabel = scores
            scene.shootsLabel = shoots
            scene.accuracyLabel = accuracy
            scene.resultTextView = resultTextView
            scene.controller = self
            
            skView.presentScene(scene)
            
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func goToMenu() {
        let menuController = self.storyboard?.instantiateViewController(withIdentifier: "menuViewController") as! MenuViewController
        self.present(menuController, animated: true, completion: nil)
    }
}
