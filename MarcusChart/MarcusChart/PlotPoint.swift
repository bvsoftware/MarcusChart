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
    
    private let actionFocus = SKAction.scaleTo(1.5, duration: 0.1)
    private let actionUnfocus = SKAction.scaleTo(1.0, duration: 0.1)
    
    private var isFocusedNow: Bool = false
    
    func startAnimation()
    {
        // Remove any actions currently underway
        self.removeAllActions()
        
        self.position = self.startingPosition
        
        let up = SKAction.moveToY(plottedPosition.y, duration: ConstantAnimationTime)
        self.runAction(up)
    }
    
    func startFocus()
    {
        // Don't start focus again if already focused
        if (isFocusedNow == true) { return }
        isFocusedNow = true
        self.runAction(actionFocus, withKey: "focus")
    }
    
    func endFocus()
    {
        self.removeActionForKey("focus")
        self.texture = SKTexture(imageNamed: "DataPoint")
        if (isFocusedNow == true)
        {
            self.runAction(actionUnfocus, withKey: "unfocus")
        }
        isFocusedNow = false
    }
    
    func isFocused() -> Bool
    {
        return isFocusedNow
    }
}