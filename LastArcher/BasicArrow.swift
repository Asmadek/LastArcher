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
        self.zPosition = -2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func createArrow(configuration: ShellConfiguration) -> BasicArrow{
        let arrow = BasicArrow(configuration: configuration)
        return arrow
    }
    
    func didMoveToScene() {
    
    }
    
    private func initPhysicsBody(){
        self.physicsBody = SKPhysicsBody.init(texture: self.texture!, alphaThreshold: 0.5, size: (self.texture?.size())!)
        self.physicsBody?.categoryBitMask = PhysicsCategory.Shell
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.collisionBitMask = PhysicsCategory.Monster | PhysicsCategory.Mage
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Monster | PhysicsCategory.Mage
    }
    
   func shoot(direction : CGVector, chargeTime: TimeInterval){
        self.initPhysicsBody()
        self.move(toParent: GameScene.mainScene!)
    
        let move_vector = direction.normalize().multiply(scalar: configuration.moveSpeed)
        self.zRotation = move_vector.angleSpriteKit()
        self.damageMultiplier = configuration.minDamageMultiplier + TimeInterval.minimum(chargeTime, configuration.maxChargeDuration)/configuration.maxChargeDuration*(configuration.maxDamageMultiplier-configuration.minDamageMultiplier)
        let moveAction = SKAction.sequence([SKAction.move(by: move_vector, duration: configuration.lifeTime),
                                            SKAction.run({self.destroy()})])
        self.run(moveAction)
    }
    
    func getDamage()-> Double {
        return configuration.baseDamage.multiplied(by: damageMultiplier)
    }
    
    func destroy(){
        self.physicsBody = nil
        removeFromParent()
    }
    
    func getNode()-> SKSpriteNode{
        return self as SKSpriteNode
    }
}
