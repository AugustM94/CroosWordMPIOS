//
//  Extensions.swift
//  crosswords
//
//  Created by August Møbius on 12/01/16.
//  Copyright © 2016 drades. All rights reserved.
//

import Foundation

extension Dictionary {
    static func loadJSONFromBundle(filename: String) -> Dictionary<String, AnyObject>? {
        if let path = NSBundle.mainBundle().pathForResource(filename, ofType: "json") {
            var data = NSData()
            var dictonary: AnyObject?
            do{
                data = try NSData(contentsOfFile: path, options: NSDataReadingOptions())
            }catch{
                
            }
            do{
                dictonary = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions())
            }
            catch{
                
            }
            
            if let dictionary = dictonary as? Dictionary<String, AnyObject> {
                return dictionary
            } else {
                print("sadsdjasdnsa")
                return nil
            }
        } else {
            print("Could not find crossword file: \(filename)")
            return nil
        }

    }
}