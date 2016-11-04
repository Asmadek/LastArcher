//
//  Bar.swift
//  LastArcher
//
//  Created by Day7 on 03.11.16.
//  Copyright © 2016 AAAR. All rights reserved.
//

import SpriteKit

class Bar: SKSpriteNode {
    var barWidth: CGFloat = 40
    var barHeight: CGFloat = 4
    var barSize: CGSize
    var progress: CGFloat
    var max: CGFloat
    
    init(barWidth: CGFloat, barHeight: CGFloat, color: UIColor, max: CGFloat, progress: CGFloat) {
        self.barSize = CGSize(width: barWidth, height: barHeight)
        self.progress = progress
        self.max = max
        
        super.init(texture: nil, color: color, size: self.barSize)
        self.updateBar(progress: progress)
    }
    
    func updateBar(progress: CGFloat) {
        let fillColor = self.color
        let borderColor = UIColor(red: 35.0/255, green: 28.0/255, blue: 40.0/255, alpha:1)
        
        // create drawing context
        UIGraphicsBeginImageContextWithOptions(barSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
        
        // draw the outline for the health bar
        borderColor.setStroke()
        let borderRect = CGRect(origin: CGPoint.zero, size: self.barSize)
        context!.stroke(borderRect, width: 2)
        
        // draw the health bar with a colored rectangle
        fillColor.setFill()
        let barWidth = (self.barSize.width - 1) * CGFloat(progress) / CGFloat(self.max)
        let barRect = CGRect(x: 0.5, y: 0.5, width: barWidth, height: self.barSize.height - 1)
        context!.fill(barRect)
        
        // extract image
        let spriteImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // set sprite texture and size
        self.texture = SKTexture(image: spriteImage!)
        self.size = self.barSize
    }
    
    func updateBarPercent(progress: CGFloat) {
        self.updateBar(progress: progress * max)
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func destroy(){
        removeFromParent()
    }
}
