//
//  ShortBowArrow.swift
//  LastArcher
//
//  Created by Александр Абугалиев on 22.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class ShortBowArrow: ShellConfiguration {
    var lifeTime = TimeInterval(7.0)
    var maxChargeDuration = TimeInterval(1.0)
    var moveSpeed = CGFloat(2700.0)
    var baseDamage = 1.0
    var minDamageMultiplier = 0.75
    var maxDamageMultiplier = 0.75
}
