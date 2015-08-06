//
//  DataSet.swift
//  MarcusChart
//
//  Created by Marc McConnell on 8/5/15.
//  Copyright (c) 2015 Marcus McConnell. All rights reserved.
//

import Foundation

class DataSet
{
    private var Nodes = Array<DataNode>()
    
    private var maxPrice: Double?
    private var minPrice: Double?
    private var maxDate: NSDate?
    private var minDate: NSDate?
    
    func getNodes() -> Array<DataNode>
    {
        // Return a copy so we're not messing with internal data
        var readOnlyCopy = Nodes
        // Sort by date to ensure we can render left to right without
        // worrying that we're messing up date sequence
        readOnlyCopy.sort({ $0.Date.compare($1.Date) == NSComparisonResult.OrderedAscending })
        return readOnlyCopy
    }
    
    func count() -> Int
    {
        return Nodes.count
    }
    
    func clearAllNodes()
    {
        Nodes = Array<DataNode>()
        maxPrice = nil
        minPrice = nil
        maxDate = nil
        minDate = nil
    }
    
    func append(node: DataNode)
    {
        self.Nodes.append(node)
        
        // MIN/MAX DATE CHECK
        if (self.minDate == nil) { self.minDate = node.Date }
        if (self.maxDate == nil) { self.maxDate = node.Date }
        
        if (node.Date.compare(minDate!) == NSComparisonResult.OrderedAscending)
        {
            // Node date less than min so replace
            self.minDate = node.Date
        }
        
        if (node.Date.compare(maxDate!) == NSComparisonResult.OrderedDescending)
        {
            // Node date greater than max so replace
            self.maxDate = node.Date
        }
        
        // MIN/MAX PRICE CHECK
        if (self.minPrice == nil) { self.minPrice = node.Price }
        if (self.maxPrice == nil) { self.maxPrice = node.Price }
        
        if (node.Price < self.minPrice) { self.minPrice = node.Price }
        if (node.Price > self.maxPrice) { self.maxPrice = node.Price }
        
    }
    
    // MARK: Accessors
    
    // NOTE: These return -1 or generic date which isn't error proof
    // TODO: Figure out a better way to error out when we don't have
    // a min/max value yet
    func getMinPrice() -> Double
    {
        if (minPrice == nil)
        {
            return -1
        } else {
            return self.minPrice!
        }
    }
    func getMaxPrice() -> Double
    {
        if (maxPrice == nil)
        {
            return -1
        } else {
            return self.maxPrice!
        }
    }
    
    func getMinDate() -> NSDate
    {
        if (minPrice == nil)
        {
            return NSDate()
        } else {
            return self.minDate!
        }
    }
    
    func getMaxDate() -> NSDate
    {
        if (maxPrice == nil)
        {
            return NSDate()
        } else {
            return self.maxDate!
        }
    }
}