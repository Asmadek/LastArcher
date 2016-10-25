//
//  MeleeFighter.swift
//  LastArcher
//
//  Created by Роман on 25.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class MeleeFighter: SKSpriteNode {
    
    var target:SKSpriteNode
    var meleePosition: CGPoint
    let meleeMovePointsPerSec:CGFloat = 480.0
    let ATTACK_RANGE:CGFloat = 40.0
    let MOVE_SPEED:CGFloat = 4.0
    let MOVE_DURATION:TimeInterval = TimeInterval(0.2)
    var isMove:Bool = true
    
    
    init(target:SKSpriteNode, position: CGPoint){
        let texture = SKTexture(imageNamed: "monster")
        self.target = target
        self.meleePosition = position
        super.init(texture: texture, color: UIColor.clear,size: texture.size())
        self.name = "monster"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func createMeleeFighter(scene : SKScene, position: CGPoint, target:SKSpriteNode) -> MeleeFighter{
        let melee = MeleeFighter(target:target, position:position)
        scene.addChild(melee)
        melee.position = position
        
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
        removeFromParent()
        isMove = false
    }

    func move(direction: CGVector){
        let moveAction = SKAction.move(by: direction.multiply(scalar: MOVE_SPEED), duration: MOVE_DURATION)
        self.run(moveAction)
        isMove = true
    }
}