//
//  Archer.swift
//  LastArcher
//
//  Created by Day7 on 22.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class Archer: SKSpriteNode {
    var weapon: Weapon? = nil
    var isBowstring: Bool = false
    var health: Double = 6.0
    var maxHealth: Int = 6
    let ARCHER_SPEED:CGFloat = 4.5
    let MIN_PULL_FORCE:CGFloat = 0.2
    
    init(){
        let texture = SKTexture(imageNamed: "ArcherBeta")
        let emptyTexture = SKTexture(imageNamed: "archer_empty")
        super.init(texture: emptyTexture, color: UIColor.clear,size: texture.size())
        self.name = "player"
        self.setWeapon(weapon: BasicBow.createWeapon(configuration: LongBow()))
        let node = SKSpriteNode(fileNamed: "Archer.sks")!.childNode(withName: "archer_body")!
        node.move(toParent: self)
        
        self.physicsBody = SKPhysicsBody.init(texture: texture, size: texture.size())
        self.physicsBody?.categoryBitMask = PhysicsCategory.Player
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.collisionBitMask = PhysicsCategory.Misc | PhysicsCategory.Monster
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Misc | PhysicsCategory.Monster
        self.physicsBody!.friction = 200.0
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
    
    func setWeapon(weapon: Weapon){
        self.weapon?.remove()
        self.weapon = weapon
        weapon.configuration.sprite.move(toParent: self)
    }
    
    func pullBowstring(){
        self.isBowstring = true
        weapon!.pullBowstring()
    }
    
    func releaseBowstring(pullForce: CGFloat){
        if(!self.isBowstring){
            return
        }
        self.isBowstring = false
        if(pullForce > MIN_PULL_FORCE){
            weapon!.releaseBowstring(pullForce: pullForce)
            NotificationCenter.default.post(CustomNotifications.ArcherShot)
        }
        
    }
        
    func move(direction: CGVector) {
          self.position = CGPoint(x: self.position.x + (direction.dx * ARCHER_SPEED),
                                  y: self.position.y + (direction.dy * ARCHER_SPEED))
    }
    
    func turn(direction: CGVector) {
        self.zRotation = direction.angleSpriteKit()
    }
    
    func didMoveToScene() {
        zPosition = 100
    }
    
    func recieveDamage(damage: Double){
        self.health = max(0.0,self.health - damage)
        GameScene.mainScene!.healthIndicator!.refreshIndicator(currentHealth: health)
        if (health < 0.001){
            self.destroy()
        }
    }
    
    func heal(heal: Double){
        self.health = max(Double(maxHealth),self.health + heal)
        GameScene.mainScene!.healthIndicator!.refreshIndicator(currentHealth: health)
    }
    
    func destroy(){
        removeFromParent()
    }
}
