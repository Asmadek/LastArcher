//
//  PhysicsCategories.swift
//  LastArcher
//
//  Created by Александр Абугалиев on 22.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

struct PhysicsCategory {
    static let None:  UInt32 = 0
    static let Shell:   UInt32 = 0x1 << 1
    static let Monster: UInt32 = 0x1 << 2
    static let Player: UInt32 = 0x1 << 3
    static let Misc: UInt32 = 0x1 << 4
    static let Mage: UInt32 = 0x1 << 5
    static let MageAttack: UInt32 = 0x1 << 6
}
