//
//  PositionHandler.swift
//  Transversal
//
//  Created by Satvik Borra on 4/3/17.
//  Copyright © 2017 sborra. All rights reserved.
//

import UIKit

class PositionHandler {
    
    var inScreenPosition : Proportion!;
    var outOfScreenPosition : Proportion!;
    
    init(inPosProp : Proportion, outPosProp : Proportion){
        inScreenPosition = inPosProp
        outOfScreenPosition = outPosProp
    }
    
    func getActualInScreenPosition() -> CGPoint{
        return inScreenPosition.actualPos()
    }
    
    func getActualOutOfScreenPosition() -> CGPoint{
        return outOfScreenPosition.actualPos()
    }
}
