//
//  MenuViewController.swift
//  LastArcher
//
//  Created by Alexander Makhnyov on 25.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//


import UIKit
import SpriteKit
import GameplayKit

class SkinSelectViewController: UIViewController {
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerDescription: UITextView!
    @IBOutlet weak var confirm: UIButton!
    
    var skin = -1;
    var weapon = -1;
    var level = "Story1";
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        confirm.addTarget(self, action: #selector(SkinSelectViewController.confirmClicked), for: .touchUpInside)
    }
    
    func confirmClicked() {

        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "startGame") {
            let svc = segue.destination as! GameViewController;
            
            svc.skin = skin
            svc.weapon = weapon
            svc.level = level
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
