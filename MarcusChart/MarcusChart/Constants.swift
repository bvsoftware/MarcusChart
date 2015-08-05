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

let ConstantChartBorderColor = SKColor.whiteColor()
let ConstantChartBorderWidth = 1.0 as CGFloat
let ConstantChartAxisColor = SKColor.whiteColor()
let ConstantChartAxisLabelColor = NSColor.whiteColor()
let ConstantChartAxisLabelFontSize = 12.0 as CGFloat
let ConstantChartAxisLabelFont = "HelveticaNeue"

