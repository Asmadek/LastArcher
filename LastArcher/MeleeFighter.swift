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
    let ATTACK_RANGE:CGFloat = 100.0
    let MOVE_SPEED:CGFloat = 4.0
    let MOVE_DURATION:TimeInterval = TimeInterval(0.2)
    var isMove:Bool = true
    
    init(target:SKSpriteNode, position: CGPoint){
        let texture = SKTexture(imageNamed: "monster")
        self.target = target
        self.meleePosition = position
        super.init(texture: texture, color: UIColor.clear,size: texture.size())
        self.name = "monster"
        self.physicsBody = SKPhysicsBody.init(texture: self.texture!, alphaThreshold: 0.5, size: (self.texture?.size())!)
        self.physicsBody?.categoryBitMask = PhysicsCategory.Monster
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.collisionBitMask = PhysicsCategory.Shell | PhysicsCategory.Monster
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Shell
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func createMeleeFighter(scene : GameScene, position: CGPoint, target:SKSpriteNode) -> MeleeFighter{
        let melee = MeleeFighter(target:target, position:position, currentScene: scene)
        scene.addChild(melee)
        melee.position = position
        melee.physicsBody?.contactTestBitMask = PhysicsCategory.Shell
        return melee
    }
    
    func attack(){
        let myPosition = CGVector(point: self.position)
        let targetPosition = CGVector(point: target.position)
        let distance = myPosition.distance(vector: targetPosition)
        let direction = targetPosition.difference(vector: myPosition).normalize()
        if (distance < ATTACK_RANGE) {
            if(isMove){
                self.removeAllActions()
            }
            hit()
        }
        else {
            if(!isMove){
                self.removeAllActions()
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
        removeFromParent()
        
        let currentScore = Int((GameScene.mainScene?.scoreLabel?.text)!)! + 1
        GameScene.mainScene?.scoreLabel?.text = String(currentScore)
        
        let currentShoots = Int((GameScene.mainScene?.shootsLabel?.text)!)!
        
        GameScene.mainScene?.accuracyLabel?.text = String(lroundf(Float(currentScore * 100) / Float(currentShoots) ))
    }

    func updateScores() {

    }
}
