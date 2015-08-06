//
//  Constants.swift
//  MarcusChart
//
//  Created by Marc McConnell on 8/5/15.
//  Copyright (c) 2015 Marcus McConnell. All rights reserved.
//

import Foundation
import SpriteKit

// Total Drawable area
let ConstantChartTotalWidth = 1024.0 as CGFloat
let ConstantChartTotalHeight = 768.0 as CGFloat

// Create a border space around the chart where we aren't drawing
let ConstantChartBuffer = 20.0 as CGFloat
let ConstantChartWidth = ConstantChartTotalWidth - (2 * ConstantChartBuffer)
let ConstantChartHeight = ConstantChartTotalHeight - (2 * ConstantChartBuffer)

// Border
let ConstantChartBorderColor = SKColor(calibratedRed: 255.0, green: 255.0, blue: 255.0, alpha: 0.25)
let ConstantChartBorderWidth = 1.0 as CGFloat

// Axis
let ConstantChartAxisColor = SKColor.whiteColor()
let ConstantChartAxisWidth = 3.0 as CGFloat
let ConstantChartAxisLabelColor = NSColor.whiteColor()
let ConstantChartAxisLabelFontSize = 12.0 as CGFloat
let ConstantChartAxisLabelFont = "HelveticaNeue"
let ConstantChartAxisBuffer = 100.0 as CGFloat
let ConstantChartAxisBufferTail = 40.0 as CGFloat
