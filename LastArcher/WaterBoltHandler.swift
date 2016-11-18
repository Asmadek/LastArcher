//
//  WaterBoltHandler.swift
//  LastArcher
//
//  Created by Александр Абугалиев on 18.11.16.
//  Copyright © 2016 AAAR. All rights reserved.
//


import SpriteKit

class WaterBoltHandler: CollisionHandler {
    func canHandle(nodeOne:SKNode, nodeTwo:SKNode) -> Bool{
        if((nodeOne.name == "water_bolt" || nodeTwo.name == "water_bolt")){
            return true
        }
        else {
            return false
        }
    }
    
    func handle(nodeOne:SKNode, nodeTwo:SKNode){
        var bolt : WaterBolt
        var player : Archer? = nil
        if(nodeOne.name == "water_bolt"){
            bolt = nodeOne as! WaterBolt
        }
        else{
            bolt = nodeTwo as! WaterBolt
        }
        if(nodeOne.name == "player"){
            player = nodeOne as? Archer
        }
        if(nodeTwo.name == "player"){
            player = nodeTwo as? Archer
        }
        if let archer = player{
            bolt.impulseToArcher()
            archer.recieveDamage(damage: bolt.DAMAGE)
        }
        bolt.destroy()
    }
}
