//
//  StringExtension.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 04.02.2021.
//

import UIKit
//Provides encoding/decoding for cyryllic symbols
extension String{
    
    var encodeUrl : String
    {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    var decodeUrl : String
    {
        return self.removingPercentEncoding!
    }
}
