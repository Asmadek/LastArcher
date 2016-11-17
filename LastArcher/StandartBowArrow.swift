//
//  StandartBowArrow.swift
//  LastArcher
//
//  Created by Александр Абугалиев on 22.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class StandartBowArrow: ShellConfiguration {
    var lifeTime = TimeInterval(7.0)
    var maxChargeDuration = TimeInterval(1.0)
    var moveSpeed = CGFloat(3300.0)
    var baseDamage = 0.5
    var minDamageMultiplier = 0.50
    var maxDamageMultiplier = 1.00
}
