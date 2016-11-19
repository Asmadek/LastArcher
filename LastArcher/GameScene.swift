//
//  GameScene.swift
//  LastArcher
//
//  Created by Alexander Makhnyov on 22.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    static var mainScene: GameScene? = nil
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    //TODO: remove archer spawn by coordinates
    let positionArcher = CGPoint(x:-10, y:-400)
    var archer: Archer = Archer()
    
    let chargeBar: Bar = Bar(barWidth: 100,
                             barHeight: 10,
                             color: UIColor(red: 130/255, green: 177/255, blue: 255/255, alpha:1),
                             max: 100,
                             progress: 0)
    
    let collisionHandler = GeneralCollisionHandler()
    
    let statistics = Statistics()
    
    var joystick: Joystick? = nil
    var healthIndicator:HealthIndicator? = nil
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var scoreLabel: UILabel? = nil
    var shootsLabel: UILabel? = nil
    var accuracyLabel: UILabel? = nil
    
    var skinId: Int = 0
    var weaponId: Int = 0

    
    func randomPosition () -> CGPoint
    {
        let minPosition = self.size.width * 0.1
        let maxPosition = self.size.width * 0.9
        let actualX = CGFloat(Float(arc4random()) / 0xFFFFFFFF) * (maxPosition - minPosition) + minPosition
        return CGPoint(x: actualX, y: self.size.height )
    }
    
    func initilizeCamera(){
        let cameraNode = SKCameraNode()
        addChild(cameraNode)
        self.camera = cameraNode
        
        let playerConstraint = SKConstraint.distance(SKRange(constantValue: 0), to: archer)
        self.camera!.constraints = [playerConstraint]
    }
    
    func initilizeControlComponents(){
        self.joystick = Joystick()
        self.healthIndicator = HealthIndicator()
        self.healthIndicator!.refreshIndicator(currentHealth: archer.health)
    }
    
    func initilizeSpawners(){
        SpawnPoint.createSpawnPoint(at: CGPoint(x:-271,y:-1408))
        SpawnPoint.createSpawnPoint(at: CGPoint(x:295,y:-365))
        SpawnPoint.createSpawnPoint(at: CGPoint(x:-32,y:733))
    }
    
    func initilizeMage(){
        let mage = FirstMage()
        self.addChild(mage)
        mage.position = CGPoint(x:200,y:-400)
    }

    override func sceneDidLoad() {
        GameScene.mainScene = self
        archer = Archer.createArcher(scene: self, position: positionArcher)
        
        initilizeCamera()
        initilizeControlComponents()
        initilizeSpawners()
        initilizeMage()

        chargeBar.zPosition = -10
        self.addChild(chargeBar)
        
        self.lastUpdateTime = 0
     
        NotificationCenter.default.addObserver(forName: CustomNotifications.StatisticsRefreshed.name, object: nil, queue: nil, using: refreshStatistics)
    }
    
    func refreshStatistics(notification: Notification){
        scoreLabel?.text? = String(statistics.frags)
        shootsLabel?.text? = String(statistics.currentShoots)
        accuracyLabel?.text? = String(statistics.accuracy)
    }

    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        chargeBar.position = CGPoint(
            x: archer.position.x,
            y: archer.position.y + 100
        )
        
        enumerateChildNodes(withName: "monster"){node,_ in
            let monster = node as! Monster
            monster.attack()
        }
        
        enumerateChildNodes(withName: "mage"){node,_ in
            let monster = node as! Monster
            monster.attack()
        }

        
        self.lastUpdateTime = currentTime
    }
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeOne = contact.bodyA.node
        let nodeTwo = contact.bodyB.node
        if(nodeOne == nil || nodeTwo == nil){
            return
        }
        if(collisionHandler.canHandle(nodeOne: nodeOne!, nodeTwo: nodeTwo!)){
            collisionHandler.handle(nodeOne: nodeOne!, nodeTwo: nodeTwo!)
        }
    }
    
    func setWeapon(weapon: Int) {
        self.weaponId = weapon
        
        var weaponConfiguration: WeaponConfiguration;
        switch self.weaponId {
        case 1:
            weaponConfiguration = LongBow()
        case 2:
            weaponConfiguration = ShortBow()
        default:
            weaponConfiguration = StandartBow()
        }
        let weapon = BasicBow.createWeapon(configuration: weaponConfiguration);
        archer.setWeapon(weapon: weapon)
    }
    
    class func level(levelName: String) -> GameScene? {
        let scene = GameScene(fileNamed: levelName)!
        scene.scaleMode = .aspectFill
        return scene
    }
}
