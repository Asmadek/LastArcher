//
//  LongBow.swift
//  LastArcher
//
//  Created by Александр Абугалиев on 23.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class LongBow: WeaponConfiguration {
    var reloadTime = TimeInterval(0.7)
    var moveAnimation = SKAction()
    var shootAnimation = SKAction()
    var shellConfiguration = LongBowArrow() as ShellConfiguration
}
