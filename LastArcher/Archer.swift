//
//  Archer.swift
//  LastArcher
//
//  Created by Day7 on 22.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class Archer: SKSpriteNode {    
    init(){
        let texture = SKTexture(imageNamed: "ArcherRAW")
        super.init(texture: texture, color: UIColor.clear,size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func createArcher(scene : SKScene, position: CGPoint){
        let archer = Archer()
        archer.position = position
        scene.addChild(archer)
    }
    
    func didMoveToScene() {
        zPosition = 100
    }
    
    func destroy(){
        removeFromParent()
    }
}
