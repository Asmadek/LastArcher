//
//  LongBowArrow.swift
//  LastArcher
//
//  Created by Александр Абугалиев on 22.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class LongBowArrow: ShellConfiguration {
    var lifeTime = TimeInterval(7.0)
    var maxChargeDuration = TimeInterval(2.0)
    var moveSpeed = CGFloat(3700.0)
    var baseDamage = 1.0
    var minDamageMultiplier = 0.30
    var maxDamageMultiplier = 2.00
}
