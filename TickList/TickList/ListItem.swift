//
//  ListItem.swift
//  TickList
//
//  Created by Kashturi V on 2018-09-25.
//  Copyright © 2018 Kashturi V. All rights reserved.
//

import Foundation
class ListItem: NSObject, NSCoding{
    var text = ""
    var checked = false
     func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(checked, forKey: "Checked")

    }
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObject(forKey: "Text") as! String
        checked = aDecoder.decodeBool(forKey: "Checked")
        super.init()
    }
    override init()
    {
        super.init()
    }
   
    
    func togCheck() {
        checked = !checked
    }
}
