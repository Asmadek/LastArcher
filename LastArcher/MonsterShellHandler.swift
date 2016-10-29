//
//  MonsterArrowHandler.swift
//  LastArcher
//
//  Created by Александр Абугалиев on 26.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class MonsterShellHandler: CollisionHandler{
    func canHandle(nodeOne:SKNode, nodeTwo:SKNode) -> Bool{
        if((nodeOne.name == "shell" && nodeTwo.name == "monster") || (nodeOne.name == "monster" && nodeTwo.name == "shell")){
            return true
        }
        else {
            return false
        }
    }
    
    func handle(nodeOne:SKNode, nodeTwo:SKNode){
        var shell : ShellType
        var monster : Monster
        if(nodeOne.name == "shell"){
            shell = nodeOne as! ShellType
        }
        else{
            shell = nodeTwo as! ShellType
        }
        if(nodeOne.name == "monster"){
            monster = nodeOne as! Monster
        }
        else{
            monster = nodeTwo as! Monster
        }
        shell.destroy()
        monster.recieveDamage(damage: shell.getDamage())
    }
}
