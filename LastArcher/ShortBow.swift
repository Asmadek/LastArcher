//
//  ShortBow.swift
//  LastArcher
//
//  Created by Александр Абугалиев on 23.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class ShortBow: WeaponConfiguration {
    var reloadTime = TimeInterval(0.3)
    var moveAnimation = SKAction()
    var shootAnimation = SKAction()
    var shellConfiguration = ShortBowArrow() as ShellConfiguration
}
