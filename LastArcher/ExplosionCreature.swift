//
//  ExplosionCreature.swift
//  LastArcher
//
//  Created by Роман on 25.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class ExplosionCreature: SKSpriteNode {
    
    var target:SKSpriteNode
    
    init(target:SKSpriteNode){
        let texture = SKTexture(imageNamed: "monster")
        self.target = target
        
        super.init(texture: texture, color: UIColor.clear,size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func random () -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random (min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    func randomDuration () -> CGFloat
    {
        let actualDuration = random(min: CGFloat(4.0), max: CGFloat(6.0))
        return actualDuration
    }

    static func createExplosionCreature(scene : SKScene, position: CGPoint, target:SKSpriteNode) /*-> ExplosionCreature*/{
        let explosion = ExplosionCreature(target:target)
        let actionMove = SKAction.move(to: target.position, duration: 4.0)
        let actionMoveDone = SKAction.removeFromParent()
        explosion.run(SKAction.sequence([actionMove, actionMoveDone]))
        explosion.position = position
        scene.addChild(explosion)
        //return explosion
    }
}
