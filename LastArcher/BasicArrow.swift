//
//  BasicArrow.swift
//  LastArcher
//
//  Created by Александр Абугалиев on 22.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class BasicArrow: SKSpriteNode {
    let SPEED_COEF = CGFloat(50.0)
    let MIN_MOVE_SPEED = CGFloat(800.0)
    let MAX_MOVE_SPEED = CGFloat(4000.0)
    
    init(){
        let texture = SKTexture(imageNamed: "BasicArrow")
        super.init(texture: texture, color: UIColor.clear,size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func createArrow(scene : SKScene, position: CGPoint, direction: CGVector){
        let arrow = BasicArrow()
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
        let moveAction = SKAction.sequence([SKAction.move(by: move_vector, duration: TimeInterval(5.0)),
                                            SKAction.run({self.destroy()})])
        self.run(moveAction)
    }
    
    func destroy(){
        removeFromParent()
    }
}
