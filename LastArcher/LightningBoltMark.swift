//
//  LightningBoltMark.swift
//  LastArcher
//
//  Created by Day7 on 18.11.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class LightningBoltMark : SKSpriteNode {
   // let DAMAGE = 0.0
    //let LIFETIME = TimeInterval(1.0)
    // let SPEED = CGFloat(1500.0)
   // var direction: CGVector

    let animation: SKAction = SKAction.animate(with: [
        SKTexture(imageNamed: "lightning_bolt_001"),
        SKTexture(imageNamed: "lightning_bolt_002"),
        SKTexture(imageNamed: "lightning_bolt_003"),
        SKTexture(imageNamed: "lightning_bolt_004"),
        SKTexture(imageNamed: "lightning_bolt_005"),
        SKTexture(imageNamed: "lightning_bolt_006"),
        SKTexture(imageNamed: "lightning_bolt_008"),
        SKTexture(imageNamed: "lightning_bolt_009"),
        SKTexture(imageNamed: "lightning_bolt_010"),
        SKTexture(imageNamed: "lightning_bolt_011"),
        SKTexture(imageNamed: "lightning_bolt_012"),
        SKTexture(imageNamed: "lightning_bolt_013"),
        ]
        , timePerFrame: 0.1)
    
    var moveAction: SKAction? = nil
    
    init(position: CGPoint){

        let texture = SKTexture(imageNamed: "archer_empty")
        super.init(texture: texture, color: UIColor.clear,size: texture.size())
        self.position = position
        GameScene.mainScene!.addChild(self)
        self.position = position
        self.name = "lightning_bolt_mark"
        self.zPosition = 100
        self.setScale(4.0)

        self.run(SKAction.sequence([animation,
                                    SKAction.removeFromParent()
            ]))
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500), execute: {
            var lightningBoltStrike = LightningBolt(position: position)
//            self.run(lightningBoltStrike.animation)
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(800), execute: {
                lightningBoltStrike.destroy()
            })
        })
        
//        self.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize.init(width: 82, height: 122))
//        self.physicsBody?.categoryBitMask = PhysicsCategory.MageAttack
//        self.physicsBody?.affectedByGravity = false
//        self.physicsBody?.isDynamic = true
//        self.physicsBody?.allowsRotation = true
//        self.physicsBody?.collisionBitMask = PhysicsCategory.Player | PhysicsCategory.Misc
//        self.physicsBody?.contactTestBitMask = PhysicsCategory.Player | PhysicsCategory.Misc
//        self.zRotation = direction.angleSpriteKit() + CGFloat(M_PI_2)

        
    }
    
    func destroy(){
        self.physicsBody = nil
        removeFromParent()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

