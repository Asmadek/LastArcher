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

class MenuViewController: UIViewController {
    @IBOutlet weak var exitBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        exitBtn.addTarget(self, action: #selector(MenuViewController.exitBtnClicked), for: .touchUpInside)
    }
    
    func exitBtnClicked() {
        exit(0)
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

}
