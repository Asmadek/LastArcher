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
    var currentScene: GameScene?
    
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
        self.physicsBody?.collisionBitMask = PhysicsCategory.Misc | PhysicsCategory.Monster
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Misc | PhysicsCategory.Monster
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func createArcher(scene : GameScene, position: CGPoint)->Archer{
        let archer = Archer()
        archer.position = position
        scene.addChild(archer)
        return archer
    }

    func shoot(chargeTime: TimeInterval) {
        let direction = CGVector.init(dx: 1 * cos(self.zRotation), dy: 1 * sin(self.zRotation))
        weapon.shoot(position: self.position, direction: direction, chargeTime: chargeTime)
        
        let currentShoots = Int((GameScene.mainScene?.shootsLabel?.text)!)! + 1
        GameScene.mainScene?.shootsLabel?.text = String(currentShoots)
        
        let currentScore = Int((GameScene.mainScene?.scoreLabel?.text)!)!
        GameScene.mainScene?.accuracyLabel?.text = String(lroundf(Float(currentScore * 100) / Float(currentShoots) ))

    }
    
    func move(direction: CGVector) {
          self.position = CGPoint(x: self.position.x + (direction.dx * 0.3),
                                  y: self.position.y + (direction.dy * 0.3))
    }
    
    func turn(direction: CGVector) {
        self.zRotation = direction.angleSpriteKit()
    }
    
    
    func didMoveToScene() {
        zPosition = 100
    }
    
    func destroy(){
        removeFromParent()
    }
}
