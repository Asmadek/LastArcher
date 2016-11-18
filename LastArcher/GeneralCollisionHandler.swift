//
//  GeneralCollisionHandler.swift
//  LastArcher
//
//  Created by Александр Абугалиев on 26.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class GeneralCollisionHandler: CollisionHandler {
    var handlers : [CollisionHandler] = []
    
    init(){
        handlers.append(MonsterShellHandler())
        handlers.append(MageShellHandler())
        handlers.append(WaterBoltHandler())
    }
    
    func canHandle(nodeOne:SKNode, nodeTwo:SKNode) -> Bool{
        for handler in handlers{
            if(handler.canHandle(nodeOne:nodeOne, nodeTwo:nodeTwo)){
                return true
            }
        }
        return false
    }
    
    func handle(nodeOne:SKNode, nodeTwo:SKNode){
        for handler in handlers{
            if(handler.canHandle(nodeOne:nodeOne, nodeTwo:nodeTwo)){
                handler.handle(nodeOne:nodeOne, nodeTwo:nodeTwo)
            }
        }
    }

}
