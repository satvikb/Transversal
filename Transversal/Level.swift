//
//  Level.swift
//  Transversal
//
//  Created by Satvik Borra on 4/3/17.
//  Copyright © 2017 sborra. All rights reserved.
//

import UIKit

class Level : NSCopying{
    
    var levelNum : Int!;
    var segments : [Segment] = []
    
    init(num: Int, _segments : [Segment]){
        levelNum = num
        segments = _segments
    }
    
//    init(clone other: Level){
//        levelNum = other.levelNum
//        segments = other.segments
//    }
    
    func copy(with zone: NSZone? = nil) -> Any{
        return Level(num: levelNum, _segments: segments)
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
    
    func numActiveCell() -> Int{
        var num = 0
        for seg in segments{
            num += seg.numActiveCell()
        }
        return num
    }
    
    func animateIn(){
        
    }
    
    func animateOut(){
        
    }
}
