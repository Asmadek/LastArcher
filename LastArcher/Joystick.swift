//
//  Joystick.swift
//  LastArcher
//
//  Created by Александр Абугалиев on 29.10.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class Joystick{
    let moveAnalogStick =  🕹(diameter: 150)
    let shootAnalogStick = AnalogJoystick(diameter: 150)
    let cameraZoomInAction = SKAction.scale(to: 1.5, duration: 0.5)
    let cameraZoomOutAction = SKAction.scale(to: 1, duration: 0.5)
    
    var chargeTime = TimeInterval(0.0)
    var mainScene:GameScene
    var archer:Archer
    var camera:SKCameraNode
    var pullForce:CGFloat
    
    init(){
        self.mainScene = GameScene.mainScene!
        self.archer = mainScene.archer
        self.camera = mainScene.camera!
        self.pullForce = 0.0
        
        moveAnalogStick.position = CGPoint(
            x: mainScene.frame.minX * 0.65,
            y: mainScene.frame.minY * 0.5)
        
        shootAnalogStick.position = CGPoint(
            x: mainScene.frame.maxX * 0.65,
            y: mainScene.frame.minY * 0.5)
        
        camera.addChild(moveAnalogStick)
        camera.addChild(shootAnalogStick)
        
        moveAnalogStick.stick.color = .gray
        shootAnalogStick.stick.color = .gray
        
        shootAnalogStick.startHandler = shootStartHandler
        shootAnalogStick.trackingHandler = shootTrackingHandler
        shootAnalogStick.stopHandler = shootStopHandler
        moveAnalogStick.trackingHandler = moveTrackingHandler
    }
    
    func shootStartHandler() {
        archer.pullBowstring()
        camera.run(cameraZoomInAction)
    }
    
    func shootStopHandler() {
        archer.releaseBowstring(pullForce: self.pullForce)
        camera.run(cameraZoomOutAction)
    }
    
    func moveTrackingHandler(data: AnalogJoystickData) {
        archer.move(direction: data.velocity.normalize())
        if (!archer.isBowstring) {
            archer.turn(direction: data.velocity)
        }
    }
    
    func shootTrackingHandler(data: AnalogJoystickData) {
        pullForce = data.velocity.length()
        if (pullForce > archer.MIN_PULL_FORCE){
            archer.turn(direction: data.velocity.multiply(scalar: -1))

        }
    }
}
