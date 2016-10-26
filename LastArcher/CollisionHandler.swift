//
//  CollisionHandler.swift
//  LastArcher
//
//  Created by Александр Абугалиев on 26.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

protocol CollisionHandler {
    func canHandle(nodeOne:SKNode, nodeTwo:SKNode) -> Bool
    func handle(nodeOne:SKNode, nodeTwo:SKNode)
}
