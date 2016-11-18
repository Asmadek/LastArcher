//
//  Statistics.swift
//  LastArcher
//
//  Created by Александр Абугалиев on 27.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class Statistics{
    var frags: Int
    var currentScore: Int
    var currentShoots: Int
    var accuracy: Int
    
    init(){
        self.currentScore = 0
        self.currentShoots = 0
        self.accuracy = 0
        self.frags = 0
        NotificationCenter.default.addObserver(forName: CustomNotifications.MonsterHit.name, object: nil, queue: nil, using: increaceScore)
        NotificationCenter.default.addObserver(forName: CustomNotifications.MonsterDied.name, object: nil, queue: nil, using: increaceFrags)
        NotificationCenter.default.addObserver(forName: CustomNotifications.ArcherShot.name, object: nil, queue: nil, using: increaceShootCount)
    }
    
    func increaceFrags(notification: Notification){
        self.frags += 1
        refreshAccuracy()
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
        if(currentShoots>0){
            self.accuracy = (currentScore*100)/currentShoots
        }
        NotificationCenter.default.post(CustomNotifications.StatisticsRefreshed)
    }
}
