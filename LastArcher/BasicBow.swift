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
    var reloadTimer: Timer
    var configuration: WeaponConfiguration
    
    init(configuration: WeaponConfiguration){
        self.configuration = configuration
        self.reloadTimer = Timer()
    }
    
    static func createWeapon(configuration: WeaponConfiguration) -> BasicBow{
        let weapon = BasicBow(configuration: configuration)
        return weapon
    }
    
    func shoot(position : CGPoint,direction : CGVector,chargeTime: TimeInterval){
        if(isReadyForShoot){
            let arrow = BasicArrow.createArrow(configuration: configuration.shellConfiguration)
            arrow.shoot(position: position, direction: direction,chargeTime: chargeTime)
            isReadyForShoot = false
            reloadTimer = Timer.scheduledTimer(timeInterval: configuration.reloadTime,target: self, selector: #selector(self.reload), userInfo: nil,repeats: false)
        }
    }
    
    @objc func reload(){
        isReadyForShoot = true
        reloadTimer.invalidate()
    }
}
