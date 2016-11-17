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
    var creaturesCount: Int = 0
    
    static func createSpawnPoint(at: CGPoint) {
       SpawnPoint(position: at)
    }
    
    init (position: CGPoint) {
        let texture = SKTexture.init(imageNamed: "archer_empty")
        super.init(texture: texture, color: UIColor.clear, size: CGSize.zero)
        GameScene.mainScene!.addChild(self)
        self.position = position
        spawnCreatures = SKAction.run {
                self.createMelee(maxCountEnemies: 5)
            }
        run(SKAction.repeatForever(SKAction.sequence([spawnCreatures!, SKAction.wait(forDuration: 10.0)])))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createMelee (maxCountEnemies: Int){
        if(creaturesCount < maxCountEnemies){
            let monster = self.addMelee()
            GameScene.mainScene!.addChild(monster)
            monster.position = self.position
            monster.setSpawnPoint(spawnPoint: self)
            creaturesCount += 1
        }
    }
    
    func decreaseCreatureCount(){
        creaturesCount -= 1
    }
    
    private func addMelee()-> MeleeFighter{
        return MeleeFighter(target: GameScene.mainScene!.archer, position: CGPoint.zero)
    }
    
}
