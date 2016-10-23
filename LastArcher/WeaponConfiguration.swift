//
//  WeaponConfiguration.swift
//  LastArcher
//
//  Created by Александр Абугалиев on 23.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

protocol WeaponConfiguration {
    var reloadTime:TimeInterval {get}
    var moveAnimation:SKAction {get}
    var shootAnimation:SKAction {get}
    var shellConfiguration: ShellConfiguration {get}
}
