//
//  BasicArrow.swift
//  LastArcher
//
//  Created by Александр Абугалиев on 22.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class BasicArrow: SKSpriteNode, ShellType {
    internal var damageMultiplier = 1.0
    internal var configuration: ShellConfiguration
    
    init(configuration: ShellConfiguration){
        let texture = SKTexture(imageNamed: "ArrowBeta")
        self.configuration = configuration
        super.init(texture: texture, color: UIColor.clear,size: texture.size())
        self.name = "shell"
        self.physicsBody = SKPhysicsBody.init(texture: self.texture!, alphaThreshold: 0.5, size: (self.texture?.size())!)
        self.physicsBody?.categoryBitMask = PhysicsCategory.Shell
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.collisionBitMask = PhysicsCategory.Monster
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Monster
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func createArrow(configuration: ShellConfiguration) -> BasicArrow{
        let arrow = BasicArrow(configuration: configuration)
        GameScene.mainScene?.addChild(arrow)
        return arrow
    }
    
    func didMoveToScene() {
        zPosition = 100
    }
    
    func shoot(position : CGPoint,direction : CGVector,chargeTime: TimeInterval){
        if (direction.length() < 0.1){
            destroy()
        }
        let move_vector = direction.normalize().multiply(scalar: configuration.moveSpeed)
        self.position = position
        self.zRotation = direction.angleSpriteKit()
        self.damageMultiplier = configuration.minDamageMultiplier + TimeInterval.minimum(chargeTime, configuration.maxChargeDuration)/configuration.maxChargeDuration*(configuration.maxDamageMultiplier-configuration.minDamageMultiplier)
        let moveAction = SKAction.sequence([SKAction.move(by: move_vector, duration: configuration.lifeTime),
                                            SKAction.run({self.destroy()})])
        self.run(moveAction)
    }
    
    func getDamage()-> Double {
        return configuration.baseDamage.multiplied(by: damageMultiplier)
    }
    
    func destroy(){
        removeFromParent()
    }
}
