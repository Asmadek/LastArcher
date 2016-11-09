//
//  WeaponConfiguration.swift
//  LastArcher
//
//  Created by Александр Абугалиев on 23.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

protocol WeaponConfiguration {
    // time between shooting
    var reloadTime:TimeInterval {get}
    // sprite animations
    var moveAnimation:SKAction {get}
    // sprite animations
    var shootAnimation:SKAction {get}
    // standart texture
    var standartTexture:SKTexture {get}
    // sprite
    var sprite: SKNode {get}
    // weapon stats
    var shellConfiguration: ShellConfiguration {get}
}
