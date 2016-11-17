//
//  HealthIndicator.swift
//  LastArcher
//
//  Created by Александр Абугалиев on 17.11.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class HealthIndicator{
    let MAX_HEALTH: Int = 10
    var indicatorNodes: [SKSpriteNode] = []
    
    init(){
        let nodeImageNames = ["hearth_right","hearth_left"]
        let X = GameScene.mainScene!.frame.minX*0.95
        let Y = GameScene.mainScene!.frame.maxY*0.75
        for i in 1...MAX_HEALTH {
            self.indicatorNodes.append(SKSpriteNode(imageNamed: nodeImageNames[i%2]))
            self.indicatorNodes.last!.setScale(0.15)
            let offset = self.indicatorNodes.last!.size.width*CGFloat(1.0*Double((i-1)/2 + 1))
            self.indicatorNodes.last!.position = CGPoint(x: X + offset, y:Y)
            GameScene.mainScene!.camera!.addChild(self.indicatorNodes.last!)
        }
    }
    
    func refreshIndicator(currentHealth: Double){
        let nodesShows = Int(currentHealth)
        for i in 0...MAX_HEALTH-1 {
            if(i < nodesShows){
                self.indicatorNodes[i].isHidden = false
            }
            else{
                self.indicatorNodes[i].isHidden = true
            }
        }
    }
}
