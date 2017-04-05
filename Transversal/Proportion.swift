//
//  Proportion.swift
//  Transversal
//
//  Created by Satvik Borra on 4/3/17.
//  Copyright © 2017 sborra. All rights reserved.
//

import UIKit

class Proportion {
    var x : CGFloat!;
    var y : CGFloat!;
    
    init(_x : CGFloat, _y : CGFloat){
        x = _x
        y = _y
    }
    
    func actualPos() -> CGPoint{
        return Screen.screenPos(x: x, y: y)
    }
    
    func actualSize() -> CGSize{
        return Screen.screenSize(width: x, height: y)
    }
}
