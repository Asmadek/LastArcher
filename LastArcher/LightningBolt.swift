//
//  LighningBolt.swift
//  LastArcher
//
//  Created by Day7 on 18.11.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class LightningBolt : SKSpriteNode {
    let DAMAGE = 6.0
    
    let animation: SKAction = SKAction.animate(with: [
        SKTexture(imageNamed: "lightning_bolt_014"),
        SKTexture(imageNamed: "lightning_bolt_015"),
        SKTexture(imageNamed: "lightning_bolt_017"),
        SKTexture(imageNamed: "lightning_bolt_018"),
        SKTexture(imageNamed: "lightning_bolt_019"),
        SKTexture(imageNamed: "lightning_bolt_020"),
        SKTexture(imageNamed: "lightning_bolt_021"),
        SKTexture(imageNamed: "lightning_bolt_022")
        ]
        , timePerFrame: 0.05)
    
    var moveAction: SKAction? = nil
    
    init(position: CGPoint){
        let texture = SKTexture(imageNamed: "archer_empty")
        
        super.init(texture: texture, color: UIColor.clear,size: texture.size())
        GameScene.mainScene!.addChild(self)
        self.position = position
        self.name = "lightning_bolt_strike"
        self.zPosition = 100
        self.setScale(2)
        
        self.run(SKAction.sequence([animation, animation.reversed()]))
        
        self.physicsBody = SKPhysicsBody.init(circleOfRadius: self.size.width / 4.5)
        self.physicsBody?.categoryBitMask = PhysicsCategory.MageAttack
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.collisionBitMask = PhysicsCategory.Player | PhysicsCategory.Misc
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Player | PhysicsCategory.Misc
        
    }
    
    func destroy(){
        self.physicsBody = nil
        removeFromParent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

