//
//  ChartScene.swift
//  MarcusChart
//
//  Created by Marc McConnell on 8/5/15.
//  Copyright (c) 2015 Marcus McConnell. All rights reserved.
//

import SpriteKit

class ChartScene: SKScene {
    
    // Holds objects that are drawn on the chart
    private var drawables = Array<PlotPoint>()
    private var mouseLocation :CGPoint = CGPointZero
    
    override func didMoveToView(view: SKView) {
    }
    
    func setupChart()
    {
        drawBorder()
        drawAxisLines()
        var data :DataSet? = DataLoader.LoadJson("stockprices")
        if (data == nil || data?.count() < 1)
        {
            let errorLabel = SKLabelNode(fontNamed: ConstantChartAxisLabelFont)
            errorLabel.fontColor = SKColor.redColor()
            errorLabel.fontSize = 32.0
            errorLabel.text = "Error: No data loaded"
            errorLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
            errorLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
            errorLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            self.addChild(errorLabel)
        } else {
            // We have some data, layout the chart
            generateDrawablesFromData(data!)
        }
    }
    
    override func mouseMoved(theEvent: NSEvent) {
        /* Code to track mouse movement */
        self.mouseLocation = theEvent.locationInNode(self)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        connectTheDots()
        checkForHover()
    }
    
    private func drawLine(startPoint: CGPoint, endPoint: CGPoint, width: CGFloat, color: SKColor)
    {
        drawLine(startPoint, endPoint: endPoint, width: width, color: color, lineName: nil)
    }
    private func drawLine(startPoint: CGPoint, endPoint: CGPoint, width: CGFloat, color: SKColor, lineName: String?)
    {
        var s = SKShapeNode()
        var path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, startPoint.x, startPoint.y)
        CGPathAddLineToPoint(path, nil, endPoint.x, endPoint.y)
        s.path = path
        s.strokeColor = color
        s.lineWidth = width
        s.name = lineName
        self.addChild(s)
    }
    
    // TODO: Not happy that I'm clearing and redrawing the path
    // for every frame. Investigate how to transform path points
    // instead of recreating each time
    private func connectTheDots()
    {
        // Delete Previous Line
        self.childNodeWithName("DataLine")?.removeFromParent()

        if (drawables.count > 1)
        {
            // Only draw lines if we have more than one point
            var line = SKShapeNode()
            line.name = "DataLine"
            var path = CGPathCreateMutable()
            CGPathMoveToPoint(path, nil, drawables[0].position.x, drawables[0].position.y)
            
            for i in 1..<drawables.count
            {
                CGPathAddLineToPoint(path, nil, drawables[i].position.x, drawables[i].position.y)
            }
            
            line.path = path
            line.strokeColor = ConstantPlotLineColor
            line.lineWidth = ConstantPlotLineWidth
            self.addChild(line)
        }
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
    
    private func drawAxisLines()
    {
        let buffer = ConstantChartBuffer + ConstantChartAxisBuffer
        let startX = buffer
        let startY = buffer
        let bufferTail = ConstantChartBuffer + ConstantChartAxisBufferTail
        let endX = ConstantChartTotalWidth - bufferTail
        let endY = ConstantChartTotalHeight - bufferTail
        
        // X Axis
        drawLine(CGPoint(x: startX, y: startY),
            endPoint: CGPoint(x: endX, y: startY),
            width: ConstantChartAxisWidth,
            color: ConstantChartAxisColor)
        
        // Y Axis
        drawLine(CGPoint(x: startX, y: startY),
            endPoint: CGPoint(x: startX, y: endY),
            width: ConstantChartAxisWidth,
            color: ConstantChartAxisColor)
        
        
    }
    
    //MARK: Generate Drawables
    private func generateDrawablesFromData(data: DataSet)
    {
        // Generate a range slightly higher/lower than actual
        // data for legibility. Note: If the data contains only
        // points located in the same dollar amount this may
        // push the graph points closer together.
        let minPriceRange :Double = floor(data.getMinPrice()) - 1
        let maxPriceRange :Double = ceil(data.getMaxPrice()) + 1
        let priceRange :Double = maxPriceRange - minPriceRange
        
        let startDate = data.getMinDate().addDays(-1)
        let endDate = data.getMaxDate().addDays(1)
        let cal = NSCalendar.currentCalendar()
        let dayUnit:NSCalendarUnit = .CalendarUnitDay
        let dateRange = cal.components(dayUnit, fromDate: startDate, toDate: endDate, options: nil)

        
        // Draw horizontal lines for Y-axis values
        var currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = .CurrencyStyle
        
        var dividerValue = minPriceRange + 1.0
        while (dividerValue < maxPriceRange)
        {
            let normalizedDividerScalar :Double = (dividerValue - minPriceRange) / priceRange
            let dividerOffset :CGFloat = (CGFloat(normalizedDividerScalar) * ConstantPlotAreaHeight)
            let dividerY = ConstantChartDataOrigin.y + dividerOffset
            
            let startPoint = CGPoint(x:ConstantChartDataOrigin.x, y: dividerY)
            let endPoint = CGPoint(x: ConstantChartDataOrigin.x + ConstantPlotAreaWidth, y: dividerY)
            drawLine(startPoint, endPoint: endPoint, width: ConstantDividerWidth, color: ConstantDividerColor)
     
            
            var priceLabel = SKLabelNode()
            priceLabel.fontName = ConstantChartAxisLabelFont
            priceLabel.fontColor = ConstantChartAxisLabelColor
            priceLabel.fontSize = ConstantChartAxisLabelFontSize
            if let formattedPrice = currencyFormatter.stringFromNumber(dividerValue)
            {
                priceLabel.text = formattedPrice
            }
            priceLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
            priceLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
            priceLabel.position = CGPoint(x: ConstantChartDataOrigin.x - 10.0, y: dividerY)
            self.addChild(priceLabel)

            dividerValue += 1
        }
        
        // Draw Date Labels for X-axis
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "M/d"
        
        var dateIndex = startDate.addDays(1)
        while (dateIndex.compare(endDate) == NSComparisonResult.OrderedAscending)
        {
            let daysFromStart = cal.components(dayUnit, fromDate: startDate, toDate: dateIndex, options: nil)
            let normalizedDateScalar :Double = (Double(daysFromStart.day) / Double(dateRange.day))
            let dateOffset :CGFloat = (CGFloat(normalizedDateScalar) * ConstantPlotAreaWidth)
            let labelX = ConstantChartDataOrigin.x + dateOffset
            
            var dateLabel = SKLabelNode()
            dateLabel.fontName = ConstantChartAxisLabelFont
            dateLabel.fontColor = ConstantChartAxisLabelColor
            dateLabel.fontSize = ConstantChartAxisLabelFontSize
            dateLabel.text = dateFormatter.stringFromDate(dateIndex)
            dateLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
            dateLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Top
            dateLabel.position = CGPoint(x: labelX, y: ConstantChartDataOrigin.y - 10.0)
            self.addChild(dateLabel)
            
            dateIndex = dateIndex.addDays(1)
        }
        
        for dataPoint in data.getNodes()
        {
            var plotPoint = PlotPoint(imageNamed: "DataPoint")
            
            // Normalize Y value (price)
            let normalizedPriceScalar :Double = (dataPoint.Price - minPriceRange) / priceRange
            let priceOffset :CGFloat = (CGFloat(normalizedPriceScalar) * ConstantPlotAreaHeight)
            let finalY = ConstantChartDataOrigin.y + priceOffset
            
            // Normalize X value (date)
            let daysFromStart = cal.components(dayUnit, fromDate: startDate, toDate: dataPoint.Date, options: nil)
            let normalizedDateScalar :Double = (Double(daysFromStart.day) / Double(dateRange.day))
            let dateOffset :CGFloat = (CGFloat(normalizedDateScalar) * ConstantPlotAreaWidth)
            let finalX = ConstantChartDataOrigin.x + dateOffset
            
            // plot point on chart
            plotPoint.plottedPosition = CGPoint(x: finalX, y: finalY)
            plotPoint.startingPosition = CGPoint(x: finalX, y: ConstantChartDataOrigin.y)
            
            self.drawables.append(plotPoint)
            self.addChild(plotPoint)
            plotPoint.startAnimation()
        }
    }
    
    func runAnimations()
    {
        for plot in drawables
        {
            plot.startAnimation()
        }
    }
    
    private func checkForHover()
    {
        let hoverRange = 10.0 as CGFloat
        
        drawVerticalLineIfInChart()
        
        for d in drawables
        {
            let hoverRect = CGRectMake(d.position.x - hoverRange, ConstantChartDataOrigin.y, hoverRange * 2, ConstantPlotAreaHeight)
            
            if hoverRect.contains(mouseLocation)
            {
                d.startFocus()
            } else {
                d.endFocus()
            }
        }
    }
    
    private func drawVerticalLineIfInChart()
    {
        self.childNodeWithName("VerticalIndicator")?.removeFromParent()
        
        let plotRect = CGRectMake(ConstantChartDataOrigin.x, ConstantChartDataOrigin.y, ConstantPlotAreaWidth, ConstantPlotAreaHeight)
        
        if plotRect.contains(self.mouseLocation)
        {
            drawLine(CGPoint(x: mouseLocation.x, y: ConstantChartDataOrigin.y), endPoint: CGPoint(x: mouseLocation.x, y:ConstantChartDataOrigin.y + ConstantPlotAreaHeight), width: ConstantDividerWidth, color: ConstantDividerColor, lineName: "VerticalIndicator")
        }
        
    }
}
