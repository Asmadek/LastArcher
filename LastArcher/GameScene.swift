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
    static var mainScene: SKScene? = nil

    //TODO: remove after debug
    var chargeTime = TimeInterval(0.0)
    var shootVector = CGVector.zero
    var currentVector = CGVector.zero
    var isBowstring = false
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    //TODO: remove archer spawn by coordinates
    let positionArcher = CGPoint(x:-10, y:-400)
    var archer = Archer()

    let cameraNode = SKCameraNode()
    
    let collisionHandler = GeneralCollisionHandler()
    
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
        let weightScene = self.frame.maxX - self.frame.minX
        let heightScene = self.frame.maxY - self.frame.minY
//        //Zoom function
//        let zoomInAction = SKAction.scale(to: 2, duration: 0)
//        cameraNode.run(zoomInAction)
        
        archer = Archer.createArcher(scene: self, position: positionArcher)
        
        self.lastUpdateTime = 0
       
        moveAnalogStick.position = CGPoint(
            x: archer.position.x - (weightScene / 2) + moveAnalogStick.radius + weightScene * 0.15,
            y: archer.position.y - (heightScene / 2) + moveAnalogStick.radius + heightScene * 0.15)
        
        shootAnalogStick.position = CGPoint(
            x: archer.position.x + (weightScene / 2) - moveAnalogStick.radius - weightScene * 0.15,
            y: archer.position.y - (heightScene / 2) + moveAnalogStick.radius + heightScene * 0.15)
        
        addChild(moveAnalogStick)
        addChild(shootAnalogStick)
        
        moveAnalogStick.stick.color = .gray
        shootAnalogStick.stick.color = .gray
        
        func shootStartHandler() {
            self.chargeTime = NSDate.timeIntervalSinceReferenceDate
            self.isBowstring = true
            
        }
        
        func shootTrackingHandler(data: AnalogJoystickData) {
            if (data.velocity.length() < 0.2){
                self.isBowstring = false
            }
            else{
                self.isBowstring = true
                archer.turn(direction: data.velocity.multiply(scalar: -1))
            }
            
        }
        
        func shootStopHandler() {
            if(self.isBowstring){
                self.chargeTime = NSDate.timeIntervalSinceReferenceDate - self.chargeTime
                archer.shoot(chargeTime: self.chargeTime)
            }
            self.isBowstring = false
        }
        
        shootAnalogStick.startHandler = shootStartHandler
        shootAnalogStick.trackingHandler = shootTrackingHandler
        shootAnalogStick.stopHandler = shootStopHandler
        
        func moveTrackingHandler(data: AnalogJoystickData) {
            
            archer.move(direction: data.velocity.normalize())
            
            if (!self.isBowstring) {
                archer.turn(direction: data.velocity)
            }
            
            self.cameraNode.position = self.archer.position
            
            moveAnalogStick.position = CGPoint(
                x: archer.position.x - (weightScene / 2) + moveAnalogStick.radius + weightScene * 0.15,
                y: archer.position.y - (heightScene / 2) + moveAnalogStick.radius + heightScene * 0.15)
            
            shootAnalogStick.position = CGPoint(
                x: archer.position.x + (weightScene / 2) - moveAnalogStick.radius - weightScene * 0.15,
                y: archer.position.y - (heightScene / 2) + moveAnalogStick.radius + heightScene * 0.15)
        }
        
        moveAnalogStick.trackingHandler = moveTrackingHandler

        addChild(self.cameraNode)
        self.cameraNode.position = self.archer.position
        self.camera = self.cameraNode
        
        run(SKAction.repeatForever(
            SKAction.sequence([SKAction.run({MeleeFighter.createMeleeFighter(scene: self, position: self.randomPosition(), target:self.archer)}),
                               SKAction.wait(forDuration: 4.0)])))
        GameScene.mainScene = self
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
    
    class func level(levelNum: Int) -> GameScene? {
        let scene = GameScene(fileNamed: "Level\(levelNum)")!
        scene.scaleMode = .aspectFill
        return scene
    }
}
