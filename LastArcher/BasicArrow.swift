//
//  BasicArrow.swift
//  LastArcher
//
//  Created by Александр Абугалиев on 22.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class BasicArrow: SKSpriteNode {
    private var damageMultiplier = 1.0
    private var configuration: ShellConfiguration
    
    init(configuration: ShellConfiguration){
        let texture = SKTexture(imageNamed: "BasicArrow")
        self.configuration = configuration
        super.init(texture: texture, color: UIColor.clear,size: texture.size())
        self.physicsBody = SKPhysicsBody.init(texture: self.texture!, alphaThreshold: 0.5, size: (self.texture?.size())!)
        self.physicsBody?.categoryBitMask = PhysicsCategory.Shell
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func createArrow(scene : SKScene, configuration: ShellConfiguration) -> BasicArrow{
        let arrow = BasicArrow(configuration: configuration)
        scene.addChild(arrow)
        return arrow
    }
    
    func didMoveToScene() {
        zPosition = 100
    }
    
    func shoot(position : CGPoint,direction : CGVector,chargeTime: TimeInterval){
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
