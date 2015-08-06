//
//  DataLoader.swift
//  MarcusChart
//
//  Created by Marc McConnell on 8/5/15.
//  Copyright (c) 2015 Marcus McConnell. All rights reserved.
//

import Foundation

class DataLoader
{

    class func LoadJson(fileName: String) -> DataSet
    {
        var data = DataSet()
        
        if let path = NSBundle.mainBundle().pathForResource(fileName as String, ofType: "json")
        {
            if let jsonData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)
            {
                if let jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary
                {
                    if let stockdata : NSArray = jsonResult["stockdata"] as? NSArray
                    {
                        let dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"

                        let count = stockdata.count
                        var index = 0
                        
                        for index in 0..<count
                        {
                            if let priceData = stockdata[index] as? NSDictionary
                            {
                                if let dateString = priceData["date"] as? String
                                {
                                    
                                    if let finalDate = dateFormatter.dateFromString(dateString)
                                    {
                                        if let priceString = priceData["close"] as? String
                                        {
                                            var node = DataNode()
                                            node.Price = (priceString as NSString).doubleValue
                                            node.Date = finalDate
                                            data.append(node)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return data
    }
    
}