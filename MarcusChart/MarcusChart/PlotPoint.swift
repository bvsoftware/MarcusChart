//
//  PlotPoint.swift
//  MarcusChart
//
//  Created by Marc McConnell on 8/5/15.
//  Copyright (c) 2015 Marcus McConnell. All rights reserved.
//

import Foundation
import SpriteKit

class PlotPoint: SKSpriteNode
{
    var plottedPosition = CGPointZero
    var startingPosition = CGPointZero
    var data = DataNode()
    
    func startAnimation()
    {
        // Remove any actions currently underway
        self.removeAllActions()
        
        self.position = self.startingPosition
        
        let up = SKAction.moveToY(plottedPosition.y, duration: ConstantAnimationTime)
        self.runAction(up)
    }
}