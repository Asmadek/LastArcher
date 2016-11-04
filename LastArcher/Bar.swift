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
    
    init(barWidth: CGFloat, barHeight: CGFloat, color: UIColor, progress: CGFloat) {
        self.barSize = CGSize(width: barWidth, height: barHeight)
        self.progress = progress
        
        super.init(texture: nil, color: color, size: size)
        
        let fillColor = UIColor(red: 113.0/255, green: 202.0/255, blue: 53.0/255, alpha:1)
        let borderColor = UIColor(red: 35.0/255, green: 28.0/255, blue: 40.0/255, alpha:1)
//        
//        // create drawing context
//        UIGraphicsBeginImageContextWithOptions(barSize, false, 0)
//        let context = UIGraphicsGetCurrentContext()
//        
//        // draw the outline for the health bar
//         borderColor.setStroke()
//        let borderRect = CGRect(origin: CGPointZero, size: barSize)
//        CGContextStrokeRectWithWidth(context, borderRect, 1)
//        
//        // draw the health bar with a colored rectangle
//        fillColor.setFill()
    }
    
    func updateBar(progress: CGFloat) {
        
//
//        let barWidth = (barSize.width - 1) * CGFloat(hp) / CGFloat(MaxHealth)
//        let barRect = CGRect(x: 0.5, y: 0.5, width: barWidth, height: barSize.height - 1)
//        CGContextFillRect(context, barRect)
//        
//        // extract image
//        let spriteImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        // set sprite texture and size
//        node.texture = SKTexture(image: spriteImage)
//        node.size = barSize
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func destroy(){
        removeFromParent()
    }
}
