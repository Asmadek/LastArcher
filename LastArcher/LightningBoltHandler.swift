//
//  LightningBoltHandler.swift
//  LastArcher
//
//  Created by Day7 on 18.11.16.
//  Copyright © 2016 AAAR. All rights reserved.
//
//
//  WaterBoltHandler.swift
//  LastArcher
//
//  Created by Александр Абугалиев on 18.11.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class LightningBoltHandler: CollisionHandler {
    func canHandle(nodeOne:SKNode, nodeTwo:SKNode) -> Bool{
        if((nodeOne.name == "lightning_bolt_strike" || nodeTwo.name == "lightning_bolt_strike")){
            return true
        }
        else {
            return false
        }
    }
    
    func handle(nodeOne:SKNode, nodeTwo:SKNode){
        var bolt : LightningBolt
        var player : Archer? = nil
        if(nodeOne.name == "lightning_bolt_strike"){
            bolt = nodeOne as! LightningBolt
        }
        else{
            bolt = nodeTwo as! LightningBolt
        }
        if(nodeOne.name == "player"){
            player = nodeOne as? Archer
        }
        if(nodeTwo.name == "player"){
            player = nodeTwo as? Archer
        }
        if let archer = player{
            archer.recieveDamage(damage: bolt.DAMAGE)
        }
    }
}

