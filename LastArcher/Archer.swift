//
//  Archer.swift
//  LastArcher
//
//  Created by Day7 on 22.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class Archer: SKSpriteNode {
    var weapon: Weapon
    
    init(){
        let texture = SKTexture(imageNamed: "ArcherBeta")
        weapon = BasicBow.createWeapon(configuration: ShortBow())
        super.init(texture: texture, color: UIColor.clear,size: texture.size())
        self.name = "player"
        //self.physicsBody = SKPhysicsBody.init(texture: self.texture!, alphaThreshold: 0.5, size: (self.texture?.size())!)
        self.physicsBody = SKPhysicsBody.init(texture: texture, size: texture.size())
        self.physicsBody?.categoryBitMask = PhysicsCategory.Player
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func createArcher(scene : SKScene, position: CGPoint)->Archer{
        let archer = Archer()
        archer.position = position
        scene.addChild(archer)
        return archer
    }

    func shoot(chargeTime: TimeInterval) {
        let direction = CGVector.init(dx: 1 * cos(self.zRotation), dy: 1 * sin(self.zRotation))
        weapon.shoot(position: self.position, direction: direction, chargeTime: chargeTime)
    }
    
    func move(direction: CGPoint) {
          self.position = CGPoint(x: self.position.x + (direction.x * 0.3),
                                  y: self.position.y + (direction.y * 0.3))
    }
    
    
    func didMoveToScene() {
        zPosition = 100
    }
    
    func destroy(){
        removeFromParent()
    }
}
