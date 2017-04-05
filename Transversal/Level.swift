//
//  Level.swift
//  Transversal
//
//  Created by Satvik Borra on 4/3/17.
//  Copyright © 2017 sborra. All rights reserved.
//

import UIKit

class Level {
    
    var levelNum : Int!;
    var segments : [Segment] = []
    
    init(num: Int, _segments : [Segment]){
        levelNum = num
        segments = _segments
    }
    
    func hasActiveCell() -> Bool{
        var hasActiveCell = false
        for seg in segments{
            if(seg.hasActiveCell()){
                hasActiveCell = true
            }
        }
        return hasActiveCell
    }
    
    func animateIn(){
        
    }
    
    func animateOut(){
        
    }
}
