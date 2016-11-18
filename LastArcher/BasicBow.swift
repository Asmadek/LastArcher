//
//  BasicBow.swift
//  LastArcher
//
//  Created by Александр Абугалиев on 23.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class BasicBow: Weapon {
    var isReadyForShoot = true
    var configuration: WeaponConfiguration
    var shell: ShellType
    var chargeTime:TimeInterval = 0.0
    
    init(configuration: WeaponConfiguration){
        self.configuration = configuration
        self.shell = BasicArrow.createArrow(configuration: configuration.shellConfiguration)
        configuration.sprite.addChild(self.shell.getNode())
        
        self.shell.getNode().setScale(5.0)
        self.shell.getNode().position = CGPoint(x: 350, y: 10)
        isReadyForShoot = true
    }
    
    static func createWeapon(configuration: WeaponConfiguration) -> BasicBow{
        let weapon = BasicBow(configuration: configuration)
        weapon.configuration.sprite.run(weapon.configuration.moveAnimation)
        return weapon
    }
    
    func reload(){
        self.shell = BasicArrow.createArrow(configuration: configuration.shellConfiguration)
        configuration.sprite.addChild(self.shell.getNode())
        
        self.shell.getNode().setScale(5.0)
        self.shell.getNode().position = CGPoint(x: 350, y: 10)
        isReadyForShoot = true
    }
    
    func pullBowstring(){
        if(isReadyForShoot){
            self.chargeTime = NSDate.timeIntervalSinceReferenceDate
            configuration.sprite.removeAllActions()
            configuration.sprite.run(configuration.shootAnimation)
            self.shell.getNode().run(SKAction.sequence([
                SKAction.move(by: CGVector(dx: -30, dy: 0), duration: 0.1),
                SKAction.wait(forDuration: self.shell.configuration.maxChargeDuration/2),
                SKAction.move(by: CGVector(dx: -30, dy: 0), duration: 0.1),
                SKAction.wait(forDuration: self.shell.configuration.maxChargeDuration/2)]))
        }
    }
    
    func releaseBowstring(pullForce: CGFloat){
        self.chargeTime = NSDate.timeIntervalSinceReferenceDate - self.chargeTime
        self.shell.getNode().setScale(1.0)
        let direction = CGVector.init(dx: cos(self.configuration.sprite.parent!.zRotation), dy: sin(self.configuration.sprite.parent!.zRotation))
        self.shell.shoot(direction : direction,chargeTime: chargeTime)
        isReadyForShoot = false
        configuration.sprite.run(
            SKAction.sequence([
                SKAction.wait(forDuration: self.configuration.reloadTime),
                SKAction.run {self.reload()},
                SKAction.setTexture(configuration.standartTexture),
                configuration.moveAnimation])
        )
    }
    
    func remove() {
        self.configuration.sprite.removeFromParent()
    }
}
