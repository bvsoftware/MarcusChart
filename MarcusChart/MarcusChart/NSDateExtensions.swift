//
//  NSDateExtensions.swift
//  MarcusChart
//
//  Created by Marc McConnell on 8/6/15.
//  Copyright (c) 2015 Marcus McConnell. All rights reserved.
//

import Foundation

extension NSDate
{
    func addDays(days: Int) -> NSDate
    {
        var dayComponent = NSDateComponents()
        dayComponent.day = days
        var calendar = NSCalendar.currentCalendar()
        //TODO: Check to make sure this won't crash in edge cases because
        // of forced unwrap
        return calendar.dateByAddingComponents(dayComponent, toDate: self, options: nil)!
    }
}