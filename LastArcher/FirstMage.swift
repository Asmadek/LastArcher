//
//  FirstMage.swift
//  LastArcher
//
//  Created by Александр Абугалиев on 18.11.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class FirstMage: SKSpriteNode, Monster {
    
    var standartAnimation: SKAction? = nil
    var attackAnimation: SKAction? = nil
    var damageAnimation: SKAction? = nil
    var deathAnimation: SKAction? = nil
    
    var isDead:Bool = false
    var health: Double = 6.0
    var target: Archer

    let castAnimation: SKAction = SKAction.animate(with: [
        SKTexture(imageNamed: "cast_effect_1_001"),
        SKTexture(imageNamed: "cast_effect_1_002"),
        SKTexture(imageNamed: "cast_effect_1_003"),
        SKTexture(imageNamed: "cast_effect_1_004"),
        SKTexture(imageNamed: "cast_effect_1_005"),
        SKTexture(imageNamed: "cast_effect_1_006"),
        SKTexture(imageNamed: "cast_effect_1_007"),
        SKTexture(imageNamed: "cast_effect_1_008"),
        SKTexture(imageNamed: "cast_effect_1_009"),
        SKTexture(imageNamed: "cast_effect_1_010"),
        SKTexture(imageNamed: "cast_effect_1_011"),
        SKTexture(imageNamed: "cast_effect_1_012"),
        SKTexture(imageNamed: "cast_effect_1_013"),
        SKTexture(imageNamed: "cast_effect_1_014"),
        SKTexture(imageNamed: "cast_effect_1_015"),
        SKTexture(imageNamed: "cast_effect_1_016"),
        SKTexture(imageNamed: "cast_effect_1_017"),
        SKTexture(imageNamed: "cast_effect_1_018"),
        SKTexture(imageNamed: "cast_effect_1_019"),
        SKTexture(imageNamed: "cast_effect_1_020"),
        SKTexture(imageNamed: "cast_effect_1_021"),
        SKTexture(imageNamed: "cast_effect_1_022"),
        SKTexture(imageNamed: "cast_effect_1_023"),
        SKTexture(imageNamed: "cast_effect_1_024"),
        SKTexture(imageNamed: "cast_effect_1_025"),
        ], timePerFrame: 0.05)
    
    init() {
        let texture = SKTexture(imageNamed: "mage_body")
        let emptyTexture = SKTexture(imageNamed: "archer_empty")
        self.target = GameScene.mainScene!.archer
        super.init(texture: emptyTexture, color: UIColor.clear,size: texture.size())
        self.name = "mage"
        self.setScale(1.3)
        self.zPosition = 2
        
        let hiddenNode = SKSpriteNode()
        hiddenNode.size = self.size
        hiddenNode.zPosition = 3
        self.addChild(hiddenNode)
        hiddenNode.position = CGPoint(x: 40.0,y: 45.0)
        hiddenNode.setScale(1.5)
        
        self.standartAnimation = SKAction.animate(with:
            [
                SKTexture(imageNamed: "mage_base_1"),
                SKTexture(imageNamed: "mage_base_2"),
                SKTexture(imageNamed: "mage_base_3"),
                SKTexture(imageNamed: "mage_base_2"),
                SKTexture(imageNamed: "mage_base_1")
            ]
            , timePerFrame: 0.2)
        
        self.attackAnimation = SKAction.sequence([
            SKAction.repeat(
                SKAction.animate(with:
                    [
                        SKTexture(imageNamed: "mage_base_1"),
                        SKTexture(imageNamed: "mage_base_2"),
                        SKTexture(imageNamed: "mage_base_3"),
                        SKTexture(imageNamed: "mage_base_4")
                    ]
                    , timePerFrame: 0.1)
            , count: 2),
            SKAction.run {hiddenNode.run(self.castAnimation)},
            SKAction.setTexture(SKTexture(imageNamed: "mage_base_1")),
            SKAction.wait(forDuration: 0.25)])
            
        
        self.damageAnimation = SKAction.sequence([SKAction.setTexture(SKTexture(imageNamed:"mage_base_1")),
                                                  SKAction.wait(forDuration: 0.3),
                                                  SKAction.scale(to: 1.6, duration: 0.15),
                                                  SKAction.scale(to: 1.3, duration: 0.15)
            ])
        
        
        
        self.physicsBody = SKPhysicsBody.init(texture: texture, size: texture.size())
        self.physicsBody?.categoryBitMask = PhysicsCategory.Mage
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.collisionBitMask = PhysicsCategory.Misc | PhysicsCategory.Monster | PhysicsCategory.Player | PhysicsCategory.Shell
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Misc | PhysicsCategory.Monster | PhysicsCategory.Player | PhysicsCategory.Shell
        
        self.run(
            SKAction.repeatForever(
                SKAction.sequence([
                    SKAction.repeat(self.standartAnimation!, count: 5),
                    self.attackAnimation!,
                    SKAction.run {self.specialAttack()}
                ])
            )
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attack(){
        if (isDead){
            return
        }
        let myPosition = CGVector(point: self.position)
        let targetPosition = CGVector(point: target.position)
        let direction = targetPosition.difference(vector: myPosition).normalize()
        self.zRotation = direction.angleSpriteKit()

    }
    
    private func specialAttack(){
        let attackNumber = arc4random_uniform(3)
        switch attackNumber {
        case 0:
            waterAttack()
        case 1:
            elementalAttack()
        case 2:
            lightningMark()
        default:
            waterAttack()
        }
    }
    
    private func waterAttack(){
        let myPosition = CGVector(point: self.position)
        let targetPosition = CGVector(point: target.position)
        let direction = targetPosition.difference(vector: myPosition).normalize()

        for i in -1...1 {
            let boltPosition = myPosition
                .sum(vector: direction.makePerpendicular().multiply(scalar: 265.0 * CGFloat(i)))
                .sum(vector: direction.multiply(scalar: 100.0 - 100.0 * CGFloat(i*i)))
            WaterBolt(direction:direction,position: boltPosition.toPoint())
        }
    }
    
    private func elementalAttack(){
        let spawnPoints = [SpawnPoint.createSpawnPoint(at: CGPoint(x: self.position.x - 100,
                                                                   y: self.position.y - 100))]
        
        for spawnPoint in spawnPoints {
            spawnPoint.createMelee(maxCountEnemies: 1)
        }

    }

    
    private func lightningBolt() {
        
    }
    
    private func lightningMark() {
        let targetPosition = target.position
        LightningBoltMark(position: targetPosition)
    }
    
    private func lightningStrike() {
        
    }
    
    func recieveDamage(damage: Double){
        health -= damage
        if(health < 0.001){
            destroy()
        }
        else{
            hitted()
        }
    }
    
    
    func hitted(){
        isDead = true
        self.run(SKAction.sequence([damageAnimation!,
                                    SKAction.run{self.isDead = false}]))
        NotificationCenter.default.post(CustomNotifications.MonsterHit)
    }
    
    func destroy(){
        isDead = true
        self.removeAllActions()
        self.physicsBody = nil
        //self.run(deathAnimation!)
        NotificationCenter.default.post(CustomNotifications.MonsterHit)
        NotificationCenter.default.post(CustomNotifications.MageDied)
    }
    
    
}
