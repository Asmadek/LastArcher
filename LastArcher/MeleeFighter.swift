//
//  MeleeFighter.swift
//  LastArcher
//
//  Created by Роман on 25.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class MeleeFighter: SKSpriteNode, Monster {
    
    var target:SKSpriteNode
    var meleePosition: CGPoint
    let ATTACK_RANGE:CGFloat = 120.0
    let MOVE_SPEED:CGFloat = 4.0
    let MOVE_DURATION:TimeInterval = TimeInterval(0.2)
    
    let moveAnimation: SKAction = SKAction.repeatForever(SKAction.animate(with: [
        SKTexture(imageNamed: "earth_elemental_walk_1"),
        SKTexture(imageNamed: "earth_elemental_walk_2"),
        SKTexture(imageNamed: "earth_elemental_walk_3"),
        SKTexture(imageNamed: "earth_elemental_walk_2")
        ], timePerFrame: 0.3))
    
    let attackAnimation: SKAction = SKAction.repeatForever(SKAction.animate(with: [
        SKTexture(imageNamed: "earth_elemental_attack_1"),
        SKTexture(imageNamed: "earth_elemental_attack_2"),
        SKTexture(imageNamed: "earth_elemental_attack_3")
        ], timePerFrame: 0.1))
    
    var isMove:Bool = true
    var isDead:Bool = false
    
    init(target:SKSpriteNode, position: CGPoint){
        let texture = SKTexture(imageNamed: "earth_elemental_walk_1")
        self.target = target
        self.meleePosition = position
        super.init(texture: texture, color: UIColor.clear,size: texture.size())
        self.setScale(0.2)
        self.name = "monster"
        self.physicsBody = SKPhysicsBody.init(circleOfRadius: 45, center: CGPoint(x: 0, y: 0))
        self.physicsBody?.categoryBitMask = PhysicsCategory.Monster
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.collisionBitMask = PhysicsCategory.Shell | PhysicsCategory.Monster
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Shell
        self.run(moveAnimation)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func createMeleeFighter(scene : GameScene, position: CGPoint, target:SKSpriteNode) -> MeleeFighter{
        let melee = MeleeFighter(target:target, position:position)
        scene.addChild(melee)
        melee.position = position
        melee.physicsBody?.contactTestBitMask = PhysicsCategory.Shell
        return melee
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
                self.run(attackAnimation)
            }
            hit()
        }
        else {
            if(!isMove){
                self.removeAllActions()
                self.run(moveAnimation)
            }
            move(direction: direction)
        }
    }
    
    func hit(){
        // removeFromParent()
        isMove = false
        
    }

    func move(direction: CGVector){
        let moveAction = SKAction.move(by: direction.multiply(scalar: MOVE_SPEED), duration: MOVE_DURATION)
        self.run(moveAction)
        isMove = true
    }
    
    func recieveDamage(damage: Double){
        if(!isDead){
            destroy()
        }
    }
    
    func destroy(){
        isDead = true
        self.removeAllActions()
        self.physicsBody = nil
        self.run(SKAction.sequence([SKAction.setTexture(SKTexture(imageNamed: "earth_elemental_dead")),
                                    SKAction.wait(forDuration: 1.5),
                                    SKAction.removeFromParent()]))
        NotificationCenter.default.post(CustomNotifications.MonsterDied)
    }

    func updateScores() {

    }
}
