//
//  TextFieldHandler.swift
//  crosswords
//
//  Created by August Møbius on 10/01/16.
//  Copyright © 2016 drades. All rights reserved.
//

import Foundation

class TextFieldHandler {
    
    func getLastC(text: String) -> String{
        var length = text.characters.count
        if length > 1 {
            return String(text.characters.last)
        }
        return text
    }

}