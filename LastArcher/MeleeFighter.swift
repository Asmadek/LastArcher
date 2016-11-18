//
//  MeleeFighter.swift
//  LastArcher
//
//  Created by Роман on 25.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class MeleeFighter: SKSpriteNode, Monster {
    var target: Archer
    var meleePosition: CGPoint
    let ATTACK_RANGE: CGFloat = 120.0
    let DAMAGE = 1.0
    let MOVE_SPEED: CGFloat = 3.0
    let MOVE_DURATION:TimeInterval = TimeInterval(0.2)
    let TIME_BETWEEN_ATTACKS:TimeInterval = TimeInterval(0.3)
    
    var moveAnimation: SKAction? = nil
    var attackAnimation: SKAction? = nil
    var deathAnimation: SKAction? = nil
    var damageAnimation: SKAction? = nil
    
    var spawnPoint: SpawnPoint? = nil
    var isMove:Bool = true
    var isDead:Bool = false
    var health:Double = 1.0
    
    init(target:Archer, position: CGPoint){
        let texture = SKTexture(imageNamed: "earth_elemental_walk_1")
        
        self.target = target
        self.meleePosition = position
        super.init(texture: texture, color: UIColor.clear,size: texture.size())
        
        self.moveAnimation = SKAction.repeatForever(SKAction.animate(with: [
            SKTexture(imageNamed: "earth_elemental_walk_1"),
            SKTexture(imageNamed: "earth_elemental_walk_2"),
            SKTexture(imageNamed: "earth_elemental_walk_3"),
            SKTexture(imageNamed: "earth_elemental_walk_2")
            ], timePerFrame: 0.5))
        
        self.attackAnimation = SKAction.repeatForever(
            SKAction.sequence(
                [SKAction.animate(with:
                    [
                        SKTexture(imageNamed: "earth_elemental_attack_1"),
                        SKTexture(imageNamed: "earth_elemental_attack_2"),
                        SKTexture(imageNamed: "earth_elemental_attack_3")
                    ],timePerFrame: 0.1),
                 SKAction.run {self.hit()},
                 SKAction.wait(forDuration: TimeInterval(0.7))
                ])
        )
        
        self.damageAnimation = SKAction.sequence([SKAction.setTexture(SKTexture(imageNamed:"earth_elemental_dead")),
                               SKAction.wait(forDuration: 0.3),
                               SKAction.scale(to: 0.26, duration: 0.15),
                               SKAction.scale(to: 0.2, duration: 0.15)
            ])
        
        self.deathAnimation = SKAction.sequence([SKAction.setTexture(SKTexture(imageNamed:"earth_elemental_dead")),
                                                 SKAction.wait(forDuration: 1.5),
                                                 SKAction.removeFromParent()])
        
        self.setScale(0.2)
        self.name = "monster"
        self.physicsBody = SKPhysicsBody.init(circleOfRadius: 45, center: CGPoint(x: 0, y: 0))
        self.physicsBody?.categoryBitMask = PhysicsCategory.Monster
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.collisionBitMask = PhysicsCategory.Shell | PhysicsCategory.Monster
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Shell
        self.run(moveAnimation!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func disablePhysics(){
        self.physicsBody = nil
    }
    
    private func enablePhysics(){
        self.physicsBody = SKPhysicsBody.init(circleOfRadius: 45, center: CGPoint(x: 0, y: 0))
        self.physicsBody?.categoryBitMask = PhysicsCategory.Monster
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.collisionBitMask = PhysicsCategory.Shell | PhysicsCategory.Monster
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Shell
    }
    
    static func createMeleeFighter(scene : GameScene, position: CGPoint, target:Archer) -> MeleeFighter{
        let melee = MeleeFighter(target:target, position:position)
        scene.addChild(melee)
        melee.position = position
        melee.physicsBody?.contactTestBitMask = PhysicsCategory.Shell
        return melee
    }
    
    private func getDirection() -> CGVector{
        let myPosition = CGVector(point: self.position)
        let targetPosition = CGVector(point: target.position)
        let direction = targetPosition.difference(vector: myPosition).normalize()
        return direction
    }
    
    func attack(){
        if (isDead){
            return
        }
        let myPosition = CGVector(point: self.position)
        let targetPosition = CGVector(point: target.position)
        let distance = myPosition.distance(vector: targetPosition)
        let direction = targetPosition.difference(vector: myPosition).normalize()
        self.zRotation = direction.angleSpriteKit()
        if (distance < ATTACK_RANGE) {
            if(isMove){
                self.removeAllActions()
                self.run(attackAnimation!)
            }
            isMove = false
        }
        else {
            if(!isMove){
                self.removeAllActions()
                self.run(moveAnimation!)
            }
            move(direction: direction)
        }
    }
    
    func hit(){
        target.physicsBody!.applyImpulse(self.getDirection().multiply(scalar: 100.0))
        target.recieveDamage(damage: DAMAGE)
        
    }

    func move(direction: CGVector){
        let moveAction = SKAction.move(by: direction.multiply(scalar: MOVE_SPEED), duration: MOVE_DURATION)
        self.run(moveAction)
        isMove = true
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
        isMove = false
        isDead = true
        self.removeAllActions()
        self.run(SKAction.sequence([damageAnimation!,
                                    SKAction.run{self.isDead = false}]))
        NotificationCenter.default.post(CustomNotifications.MonsterHit)
    }
    
    func destroy(){
        isDead = true
        self.removeAllActions()
        self.disablePhysics()
        self.run(deathAnimation!)
        NotificationCenter.default.post(CustomNotifications.MonsterHit)
        NotificationCenter.default.post(CustomNotifications.MonsterDied)
    }

    func updateScores() {

    }
    
    func setSpawnPoint(spawnPoint: SpawnPoint){
        self.spawnPoint = spawnPoint
    }
    
    override func removeFromParent() {
        if let sp = spawnPoint {
            sp.decreaseCreatureCount()
        }
        super.removeFromParent()
    }
}
