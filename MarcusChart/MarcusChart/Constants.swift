//
//  Constants.swift
//  MarcusChart
//
//  Created by Marc McConnell on 8/5/15.
//  Copyright (c) 2015 Marcus McConnell. All rights reserved.
//

import Foundation
import SpriteKit

// MARK: Total Drawable area
let ConstantChartTotalWidth = 1024.0 as CGFloat
let ConstantChartTotalHeight = 768.0 as CGFloat

// MARK: Create a border space around the chart where we aren't drawing
let ConstantChartBuffer = 20.0 as CGFloat
let ConstantChartWidth = ConstantChartTotalWidth - (2 * ConstantChartBuffer)
let ConstantChartHeight = ConstantChartTotalHeight - (2 * ConstantChartBuffer)

// MARK: Border
let ConstantChartBorderColor = SKColor(calibratedRed: 255.0, green: 255.0, blue: 255.0, alpha: 0.25)
let ConstantChartBorderWidth = 1.0 as CGFloat

// MARK: Axis
let ConstantChartAxisColor = SKColor.whiteColor()
let ConstantChartAxisWidth = 3.0 as CGFloat
let ConstantChartAxisLabelColor = NSColor.whiteColor()
let ConstantChartAxisLabelFontSize = 12.0 as CGFloat
let ConstantChartAxisLabelFont = "HelveticaNeue"
let ConstantChartAxisBuffer = 100.0 as CGFloat
let ConstantChartAxisBufferTail = 40.0 as CGFloat

// MARK: Data plotting
let ConstantPlotAreaWidth = ConstantChartWidth - ConstantChartAxisBuffer - ConstantChartAxisBufferTail
let ConstantPlotAreaHeight = ConstantChartHeight - ConstantChartAxisBuffer - ConstantChartAxisBufferTail
let ConstantChartDataOrigin = CGPoint(x: ConstantChartBuffer + ConstantChartAxisBuffer,
    y: ConstantChartBuffer + ConstantChartAxisBuffer)
let ConstantPlotLineColor = SKColor(calibratedRed: 1.0/255.0, green: 171.0/255.0, blue: 238.0/255.0, alpha: 0.5)
let ConstantPlotLineWidth = 5.0 as CGFloat

// MARK: Divider Lines
let ConstantDividerColor = SKColor(calibratedRed: 255.0, green: 255.0, blue: 255.0, alpha: 0.5)
let ConstantDividerWidth = 1.0 as CGFloat

// MARK: Animation
let ConstantAnimationTime = 1.0 as NSTimeInterval
