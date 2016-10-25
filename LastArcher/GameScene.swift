//
//  GameScene.swift
//  LastArcher
//
//  Created by Alexander Makhnyov on 22.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    //TODO: remove after debug
    var chargeTime = TimeInterval(0.0)
    var shootVector = CGVector.zero
    var currentVector = CGVector.zero
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    //TODO: remove archer spawn by coordinates
    let positionArcher = CGPoint(x:-10, y:-400)
    var archer = Archer()

    let cameraNode = SKCameraNode()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    let setJoystickStickImageBtn = SKLabelNode(), setJoystickSubstrateImageBtn = SKLabelNode()
    
    let moveAnalogStick =  🕹(diameter: 150)
    let shootAnalogStick = AnalogJoystick(diameter: 150)

    func randomPosition () -> CGPoint
    {
        let minPosition = self.size.width * 0.1
        let maxPosition = self.size.width * 0.9
        let actualX = CGFloat(Float(arc4random()) / 0xFFFFFFFF) * (maxPosition - minPosition) + minPosition
        return CGPoint(x: actualX, y: self.size.height )
    }

    override func sceneDidLoad() {
        
        
        
        archer = Archer.createArcher(scene: self, position: positionArcher)
        
        self.lastUpdateTime = 0
       
        moveAnalogStick.position = CGPoint(x: archer.position.x - ((self.frame.maxX - self.frame.minX) / 2) + moveAnalogStick.radius + 50, y: archer.position.y - ((self.frame.maxY - self.frame.minY) / 2) + moveAnalogStick.radius + 50)
        
        shootAnalogStick.position = CGPoint(x: archer.position.x + ((self.frame.maxX - self.frame.minX) / 2) - moveAnalogStick.radius - 50, y: archer.position.y - ((self.frame.maxY - self.frame.minY) / 2) + moveAnalogStick.radius + 50)
        
        addChild(moveAnalogStick)
        addChild(shootAnalogStick)
        
        moveAnalogStick.stick.color = .gray
        shootAnalogStick.stick.color = .gray
        
        func shootStartHandler() {
            self.chargeTime = NSDate.timeIntervalSinceReferenceDate
        }
        
        func shootTrackingHandler(data: AnalogJoystickData) {
            self.currentVector = CGVector(dx: sin(data.angular), dy: -1 * cos(data.angular))
        }
        
        func shootStopHandler() {
            self.chargeTime = NSDate.timeIntervalSinceReferenceDate - self.chargeTime
            let arrow = BasicArrow.createArrow(scene: self, configuration: LongBowArrow())
            arrow.shoot(position: self.archer.position, direction: self.currentVector, chargeTime: self.chargeTime)
        }
        
        shootAnalogStick.startHandler = shootStartHandler
        shootAnalogStick.trackingHandler = shootTrackingHandler
        shootAnalogStick.stopHandler = shootStopHandler
        
        func moveTrackingHandler(data: AnalogJoystickData) {
            
            self.archer.position = CGPoint(x: self.archer.position.x + (data.velocity.x * 0.3), y: self.archer.position.y + (data.velocity.y * 0.3))
            
            self.cameraNode.position = self.archer.position
            
            moveAnalogStick.position = CGPoint(x: archer.position.x - ((self.frame.maxX - self.frame.minX) / 2) + moveAnalogStick.radius + 50, y: archer.position.y - ((self.frame.maxY - self.frame.minY) / 2) + moveAnalogStick.radius + 50)
            
            shootAnalogStick.position = CGPoint(x: archer.position.x + ((self.frame.maxX - self.frame.minX) / 2) - moveAnalogStick.radius - 50, y: archer.position.y - ((self.frame.maxY - self.frame.minY) / 2) + moveAnalogStick.radius + 50)
        }
        
        moveAnalogStick.trackingHandler = moveTrackingHandler

        addChild(self.cameraNode)
        self.cameraNode.position = self.archer.position
        self.camera = self.cameraNode
        
        run(SKAction.repeatForever(
            SKAction.sequence([SKAction.run({MeleeFighter.createMeleeFighter(scene: self, position: self.randomPosition(), target:self.archer)}),
                               SKAction.wait(forDuration: 2.0)])))
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
        
        enumerateChildNodes(withName: "monster"){node,_ in
            let monster = node as! MeleeFighter
            monster.attack()
        }
        
        self.lastUpdateTime = currentTime
        
    }
    
    class func level(levelNum: Int) -> GameScene? {
        let scene = GameScene(fileNamed: "Level\(levelNum)")!
        scene.scaleMode = .aspectFill
        return scene
    }
}
