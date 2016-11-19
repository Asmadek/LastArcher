//
//  WaterBolt.swift
//  LastArcher
//
//  Created by Александр Абугалиев on 18.11.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class WaterBolt : SKSpriteNode {
    let DAMAGE = 2.0
    let LIFETIME = TimeInterval(5.0)
    let SPEED = CGFloat(1500.0)
    var direction: CGVector
    
    let animation: SKAction = SKAction.animate(with: [
            SKTexture(imageNamed: "water_bolt_001"),
            SKTexture(imageNamed: "water_bolt_002"),
            SKTexture(imageNamed: "water_bolt_003"),
            SKTexture(imageNamed: "water_bolt_004"),
            SKTexture(imageNamed: "water_bolt_005"),
            SKTexture(imageNamed: "water_bolt_006"),
            SKTexture(imageNamed: "water_bolt_008"),
            SKTexture(imageNamed: "water_bolt_009"),
            SKTexture(imageNamed: "water_bolt_010"),
            SKTexture(imageNamed: "water_bolt_011"),
            SKTexture(imageNamed: "water_bolt_012"),
            SKTexture(imageNamed: "water_bolt_013"),
            SKTexture(imageNamed: "water_bolt_014"),
            SKTexture(imageNamed: "water_bolt_015"),
            SKTexture(imageNamed: "water_bolt_017"),
            SKTexture(imageNamed: "water_bolt_018"),
            SKTexture(imageNamed: "water_bolt_019"),
            SKTexture(imageNamed: "water_bolt_020"),
            SKTexture(imageNamed: "water_bolt_021"),
            SKTexture(imageNamed: "water_bolt_022")
        ]
        , timePerFrame: 0.05)
    
    var moveAction: SKAction? = nil
    
    init(direction: CGVector, position: CGPoint){
        let texture = SKTexture(imageNamed: "archer_empty")
        self.direction = direction.multiply(scalar: SPEED)
        self.moveAction = SKAction.move(by: self.direction, duration: LIFETIME)
        
        super.init(texture: texture, color: UIColor.clear,size: texture.size())
        GameScene.mainScene!.addChild(self)
        self.position = position
        self.name = "water_bolt"
        self.zPosition = 10
        self.setScale(2.0)
        
        self.run(SKAction.repeatForever(animation))
        self.run(moveAction!)
        
        self.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize.init(width: 82, height: 122))
        self.physicsBody?.categoryBitMask = PhysicsCategory.MageAttack
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.collisionBitMask = PhysicsCategory.Player | PhysicsCategory.Misc
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Player | PhysicsCategory.Misc
        self.zRotation = direction.angleSpriteKit() + CGFloat(M_PI_2)
        
    }
    
    func destroy(){
        self.physicsBody = nil
        removeFromParent()
    }
    
    func impulseToArcher(){
        GameScene.mainScene!.archer.physicsBody!.applyImpulse(self.direction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
