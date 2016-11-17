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
    var chargeTime:TimeInterval {get}
    var isReadyForShoot:Bool {get}
    
    func pullBowstring()
    func releaseBowstring(pullForce: CGFloat)
    func remove()
}
