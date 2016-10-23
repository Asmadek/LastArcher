//
//  Weapon.swift
//  LastArcher
//
//  Created by Александр Абугалиев on 23.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

protocol Weapon {
    var configuration: WeaponConfiguration {get}
    func shoot(position : CGPoint,direction : CGVector,chargeTime: TimeInterval)
}
