//
//  ShellConfigurationProtocol.swift
//  LastArcher
//
//  Created by Александр Абугалиев on 22.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

protocol ShellConfiguration {
    var lifeTime:TimeInterval {get}
    var maxChargeDuration:TimeInterval {get}
    var moveSpeed:CGFloat {get}
    var baseDamage:Double {get}
    var minDamageMultiplier:Double {get}
    var maxDamageMultiplier:Double {get}
}
