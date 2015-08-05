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
    private var MinDate: NSDate?
    
    func getNodes() -> Array<DataNode>
    {
        var readOnlyCopy = Nodes
        return readOnlyCopy
    }
    
    func clearAllNodes()
    {
        Nodes = Array<DataNode>()
    }
}