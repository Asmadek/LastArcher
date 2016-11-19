//
//  StartBattleHandler.swift
//  LastArcher
//
//  Created by Alexander Makhnyov on 19.11.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class StartBattleHandler: CollisionHandler{
    func canHandle(nodeOne:SKNode, nodeTwo:SKNode) -> Bool{
        if((nodeOne.name == "start" && nodeTwo.name == "player") || (nodeOne.name == "player" && nodeTwo.name == "start")){
            return true
        }
        else {
            return false
        }
    }
    
    func handle(nodeOne:SKNode, nodeTwo:SKNode){
        GameScene.mainScene?.startFinalBattle()
    }
}
