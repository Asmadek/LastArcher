//
//  SpawnPoint.swift
//  LastArcher
//
//  Created by Роман on 17.11.16.
//  Copyright © 2016 AAAR. All rights reserved.
//


import SpriteKit

class SpawnPoint: SKSpriteNode {
    private var spawnCreatures: SKAction? = nil
    
    init (position: CGPoint) {
        let texture = SKTexture.init(imageNamed: "archer_empty")
        super.init(texture: texture, color: UIColor.clear, size: CGSize.zero)
        GameScene.mainScene!.addChild(self)
        self.position = position
        spawnCreatures = SKAction(self.createMelee(maxCountEnemies: 5))
        run(SKAction.repeatForever(SKAction.sequence([spawnCreatures!, SKAction.wait(forDuration: 10.0)])))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createMelee (maxCountEnemies: Int){
        if(self.children.count <= maxCountEnemies){
            let monster = self.addMelee()
            self.addChild(monster)
            monster.position = CGPoint.zero
            monster.move(toParent: GameScene.mainScene!)
        }
    }
    
    private func addMelee()-> MeleeFighter{
        return MeleeFighter(target: GameScene.mainScene!.archer, position: CGPoint.zero)
    }
    
}
