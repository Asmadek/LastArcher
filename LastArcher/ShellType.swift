//
//  Shell.swift
//  LastArcher
//
//  Created by Александр Абугалиев on 23.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

protocol ShellType {
    var damageMultiplier:Double {get}
    var configuration:ShellConfiguration {get}
    
    func shoot(position : CGPoint,direction : CGVector,chargeTime: TimeInterval)
    func getDamage()-> Double
    func destroy()
}
