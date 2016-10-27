//
//  Statistics.swift
//  LastArcher
//
//  Created by Александр Абугалиев on 27.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class Statistics{
    var currentScore: Int
    var currentShoots: Int
    var accuracy: Int
    
    init(){
        self.currentScore = 0
        self.currentShoots = 0
        self.accuracy = 0
        NotificationCenter.default.addObserver(forName: CustomNotifications.MonsterDied.name, object: nil, queue: nil, using: increaceScore)
        NotificationCenter.default.addObserver(forName: CustomNotifications.ArcherShot.name, object: nil, queue: nil, using: increaceShootCount)
    }
    
    func increaceScore(notification: Notification){
        self.currentScore += 1
        refreshAccuracy()
    }
    
    func increaceShootCount(notification: Notification){
        self.currentShoots += 1
        refreshAccuracy()
    }
    
    func refreshAccuracy(){
        self.accuracy = (currentScore*100)/currentShoots
        NotificationCenter.default.post(CustomNotifications.StatisticsRefreshed)
    }
}
