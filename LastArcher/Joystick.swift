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
    let cameraZoomOutAction = SKAction.scale(to: 1.5, duration: 0.5)
    let cameraZoomInAction = SKAction.scale(to: 1, duration: 0.5)
 //   let chargeBowStringAction = SKAction.moveBy(x: <#T##CGFloat#>, y: <#T##CGFloat#>, duration: <#T##TimeInterval#>)
    
    var chargeTime = TimeInterval(0.0)
    var mainScene:GameScene
    var archer:Archer
    var camera:SKCameraNode
    var pullForce:CGFloat
    var cameraTriggered:Bool
    
    var chargeBar:Bar
    var pupsik:CGFloat = 10
    var startChargeTime = NSDate.timeIntervalSinceReferenceDate
    
    
    init(){
        self.mainScene = GameScene.mainScene!
        self.archer = mainScene.archer
        self.camera = mainScene.camera!
        self.pullForce = 0.0
        self.cameraTriggered = false
        self.chargeBar = mainScene.chargeBar
        
        moveAnalogStick.position = CGPoint(
            x: mainScene.frame.minX * 0.6,
            y: mainScene.frame.minY * 0.5)
        
        shootAnalogStick.position = CGPoint(
            x: mainScene.frame.maxX * 0.6,
            y: mainScene.frame.minY * 0.5)
        
        camera.addChild(moveAnalogStick)
        camera.addChild(shootAnalogStick)
        
        moveAnalogStick.stick.color = .gray
        shootAnalogStick.stick.color = .gray
        
        moveAnalogStick.zPosition = 100
        shootAnalogStick.zPosition = 100
        
        shootAnalogStick.startHandler = shootStartHandler
        shootAnalogStick.trackingHandler = shootTrackingHandler
        shootAnalogStick.stopHandler = shootStopHandler
        moveAnalogStick.trackingHandler = moveTrackingHandler
    }
    
    func shootStartHandler() {
        if (archer.weapon!.isReadyForShoot){
            archer.pullBowstring()
            chargeBar.zPosition = 111
            self.startChargeTime = NSDate.timeIntervalSinceReferenceDate
        }
    }
    
    func shootStopHandler() {
        if (archer.isBowstring){
            archer.releaseBowstring(pullForce: self.pullForce)
            camera.run(cameraZoomInAction)
            cameraTriggered = false
            
            chargeBar.zPosition = -10
            pupsik = 0.0
            chargeBar.updateBarPercent(progress: pupsik)
        }
    }
    
    func moveTrackingHandler(data: AnalogJoystickData) {
        archer.move(direction: data.velocity.normalize())
        if (!archer.isBowstring) {
            archer.turn(direction: data.velocity)
        }

    }
    
    func shootTrackingHandler(data: AnalogJoystickData) {
        if (archer.isBowstring){
            pullForce = data.velocity.length()
            if (pullForce > archer.MIN_PULL_FORCE){
                archer.turn(direction: data.velocity.multiply(scalar: -1))
                
            }
            if (((NSDate.timeIntervalSinceReferenceDate - archer.weapon!.chargeTime) > 0.7) && (cameraTriggered == false)){
                camera.run(cameraZoomOutAction)
                cameraTriggered = true
            }
            pupsik = (CGFloat((NSDate.timeIntervalSinceReferenceDate - self.startChargeTime) / archer.weapon!.configuration.shellConfiguration.maxChargeDuration))
            
            print(NSDate.timeIntervalSinceReferenceDate - self.startChargeTime)
            print(archer.weapon!.configuration.shellConfiguration.maxChargeDuration)
            print(pupsik)
            chargeBar.updateBarPercent(progress: pupsik)
        }
    }
}
