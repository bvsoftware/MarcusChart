//
//  ChartScene.swift
//  MarcusChart
//
//  Created by Marc McConnell on 8/5/15.
//  Copyright (c) 2015 Marcus McConnell. All rights reserved.
//

import SpriteKit

class ChartScene: SKScene {
    
    private var dataNodes = Array<DataNode>()
    
    override func didMoveToView(view: SKView) {
    }
    
    func setupChart()
    {
        drawBorder()
        dataNodes = DataLoader.LoadJson("stockprices")
        if (dataNodes.count < 1)
        {
            let errorLabel = SKLabelNode(fontNamed: ConstantChartAxisLabelFont)
            errorLabel.fontColor = SKColor.redColor()
            errorLabel.fontSize = 32.0
            errorLabel.text = "Error: No data loaded"
            errorLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
            errorLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
            errorLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            self.addChild(errorLabel)
        }
        
        for p in dataNodes
        {
            NSLog("Price: \(p.Price), Date: \(p.Date)")
        }

    }
    
    override func mouseMoved(theEvent: NSEvent) {
        /* Code to track mouse movement */
        let location = theEvent.locationInNode(self)
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    private func drawLine(startPoint: CGPoint, endPoint: CGPoint, width: CGFloat, color: SKColor)
    {
        var s = SKShapeNode()
        var path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, startPoint.x, startPoint.y)
        CGPathAddLineToPoint(path, nil, endPoint.x, endPoint.y)
        s.path = path
        s.strokeColor = color
        s.lineWidth = width
        self.addChild(s)
        
    }
    
    // Draws the rectangle border around the chart
    private func drawBorder()
    {
        // This could be turned into a generic draw rectangle function
        // as sometime in the future should we need to draw more
        // rectangles
        
        let startX = ConstantChartBuffer
        let endX = startX + ConstantChartWidth
        let startY = ConstantChartBuffer
        let endY = startY + ConstantChartHeight
        
        // Bottom Border
        drawLine(CGPoint(x: startX, y: startY),
            endPoint: CGPoint(x: endX, y: startY),
            width: ConstantChartBorderWidth,
            color: ConstantChartBorderColor)
        
        // Top Border
        drawLine(CGPoint(x: startX, y: endY),
            endPoint: CGPoint(x: endX, y: endY),
            width: ConstantChartBorderWidth,
            color: ConstantChartBorderColor)
        
        // Left Border
        drawLine(CGPoint(x: startX, y: startY),
            endPoint: CGPoint(x: startX, y: endY),
            width: ConstantChartBorderWidth,
            color: ConstantChartBorderColor)
        
        // Right Border
        drawLine(CGPoint(x: endX, y: startY),
            endPoint: CGPoint(x: endX, y: endY),
            width: ConstantChartBorderWidth,
            color: ConstantChartBorderColor)
        
    }
}
