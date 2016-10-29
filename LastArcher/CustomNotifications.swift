//
//  Notifications.swift
//  LastArcher
//
//  Created by Александр Абугалиев on 27.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//
import SpriteKit

struct CustomNotifications {
    static let MonsterDied = Notification(name: Notification.Name(rawValue: "MonsterDied"))
    static let ArcherShot = Notification(name: Notification.Name(rawValue: "ArcherShot"))
    static let StatisticsRefreshed = Notification(name: Notification.Name(rawValue: "StatisticsRefreshed"))
}
