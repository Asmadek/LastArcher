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
    
    @IBOutlet weak var standartBowBtn: UIImageView!
    @IBOutlet weak var longBowBtn: UIImageView!
    @IBOutlet weak var shortBowBtn: UIImageView!
    
    @IBOutlet weak var greenSkinBtn: UIImageView!
    @IBOutlet weak var blueSkinBtn: UIImageView!
    @IBOutlet weak var redSkinBtn: UIImageView!
    
    var skin = -1;
    var weapon = -1;
    var level = "Story1";
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        confirm.addTarget(self, action: #selector(SkinSelectViewController.confirmClicked), for: .touchUpInside)
        
        standartBowBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SkinSelectViewController.standartBowBtnClicked)))
        standartBowBtn.isUserInteractionEnabled = true

        longBowBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SkinSelectViewController.longBowBtnClicked)))
        longBowBtn.isUserInteractionEnabled = true

        shortBowBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SkinSelectViewController.shortBowBtnClicked)))
        shortBowBtn.isUserInteractionEnabled = true
//
//        greenSkinBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SkinSelectViewController.greenSkinBtnClicked)))
//        greenSkinBtn.isUserInteractionEnabled = true
//
//        blueSkinBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SkinSelectViewController.blueSkinBtnClicked)))
//        blueSkinBtn.isUserInteractionEnabled = true
//
//        redSkinBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SkinSelectViewController.redSkinBtnClicked)))
//        redSkinBtn.isUserInteractionEnabled = true

    }
    
    func confirmClicked() {
        
    }
    
    func standartBowBtnClicked() {
        self.weapon = 0;
        setWeaponBorders()
    }
    
    func longBowBtnClicked() {
        self.weapon = 1;
        setWeaponBorders()
    }
    
    func shortBowBtnClicked() {
        self.weapon = 2;
        setWeaponBorders()
    }
    
    func setWeaponBorders() {
        self.standartBowBtn.layer.borderWidth = (self.weapon == 0) ? 2 : 0
        self.standartBowBtn.layer.borderColor = UIColor(red:0/255.0, green:0/255.0, blue:255/255.0, alpha: 1.0).cgColor
        self.longBowBtn.layer.borderWidth = (self.weapon == 1) ? 2 : 0
        self.longBowBtn.layer.borderColor = UIColor(red:0/255.0, green:0/255.0, blue:255/255.0, alpha: 1.0).cgColor
        self.shortBowBtn.layer.borderWidth = (self.weapon == 2) ? 2 : 0
        self.shortBowBtn.layer.borderColor = UIColor(red:0/255.0, green:0/255.0, blue:255/255.0, alpha: 1.0).cgColor
    }
    
    
//    func greenSkinBtnClicked() {
//        self.skin = 0;
//        setSkinBorders()
//    }
//    
//    func blueSkinBtnClicked() {
//        self.skin = 1;
//        setSkinBorders()
//    }
//    
//    func redSkinBtnClicked() {
//        self.skin = 2;
//        setSkinBorders()
//    }
//    
//    func setSkinBorders() {
//        self.greenSkinBtn.layer.borderWidth = (self.skin == 0) ? 2 : 0
//        self.greenSkinBtn.layer.borderColor = UIColor(red:0/255.0, green:0/255.0, blue:255/255.0, alpha: 1.0).cgColor
//        self.blueSkinBtn.layer.borderWidth = (self.skin == 1) ? 2 : 0
//        self.blueSkinBtn.layer.borderColor = UIColor(red:0/255.0, green:0/255.0, blue:255/255.0, alpha: 1.0).cgColor
//        self.redSkinBtn.layer.borderWidth = (self.skin == 2) ? 2 : 0
//        self.redSkinBtn.layer.borderColor = UIColor(red:0/255.0, green:0/255.0, blue:255/255.0, alpha: 1.0).cgColor
//    }
    
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
