//
//  BasicArrow.swift
//  LastArcher
//
//  Created by Александр Абугалиев on 22.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class BasicArrow: SKSpriteNode {
    private let LIFE_TIME = TimeInterval(7.0)
    private let SPEED_COEF = CGFloat(50.0)
    private let MIN_MOVE_SPEED = CGFloat(800.0)
    private let MAX_MOVE_SPEED = CGFloat(4000.0)
    let DAMAGE = 1
    
    init(){
        let texture = SKTexture(imageNamed: "BasicArrow")
        super.init(texture: texture, color: UIColor.clear,size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func createArrow(scene : SKScene, position: CGPoint, direction: CGVector){
        let arrow = BasicArrow()
        arrow.physicsBody = SKPhysicsBody.init(texture: arrow.texture!, alphaThreshold: 0.5, size: (arrow.texture?.size())!)
        arrow.physicsBody?.categoryBitMask = PhysicsCategory.Shell
        arrow.physicsBody?.affectedByGravity = false
        arrow.physicsBody?.isDynamic = false
        scene.addChild(arrow)
        arrow.shoot(position: position, direction: direction)
    }
    
    func didMoveToScene() {
        zPosition = 100
    }
    
    func shoot(position : CGPoint,direction : CGVector){
        var move_speed = CGFloat.minimum(direction.length() * SPEED_COEF, MAX_MOVE_SPEED)
        move_speed = CGFloat.maximum(move_speed, MIN_MOVE_SPEED)
        let move_vector = direction.normalize().multiply(scalar: move_speed)
        self.position = position
        self.zRotation = direction.angleSpriteKit()
        let moveAction = SKAction.sequence([SKAction.move(by: move_vector, duration: LIFE_TIME),
                                            SKAction.run({self.destroy()})])
        self.run(moveAction)
    }
    
    func destroy(){
        removeFromParent()
    }
}
