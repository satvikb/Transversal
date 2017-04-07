//
//  LineSegment.swift
//  Transversal
//
//  Created by Satvik Borra on 4/5/17.
//  Copyright © 2017 sborra. All rights reserved.
//

import UIKit

enum LineSegmentDirection {
    case Horizontal;
    case Vertical;
}

class LineSegment : Segment{
    
    init(frame: CGRect, _id: Int, _numCells : Int, _activeCells : [Int], _layers:[Int:Int], dir : LineSegmentDirection = .Horizontal, box : Bool = true){
        super.init(frame: frame, _id: _id, _numCells: _numCells, _activeCells: _activeCells, _layers: _layers)
        
        var cellLength : CGFloat!;
        
        switch dir {
        case .Horizontal:
            cellLength = CGFloat(frame.size.width)/CGFloat(numCells)
            break;
        case .Vertical:
            cellLength = CGFloat(frame.size.height)/CGFloat(numCells)
            break;
        }
        
        var newFrame = frame
        if(box){
            switch dir {
            case .Horizontal:
                newFrame.size.height = cellLength
                break;
            case .Vertical:
                newFrame.size.width = cellLength
                break;
            }
        }
        
        
        inScreenPosition = newFrame.origin
        
        for i in 0...numCells-1 {
            var pos : CGPoint! = CGPoint.zero;
            var size : CGSize! = CGSize.zero;
            
            switch dir {
            case .Horizontal:
                pos = CGPoint(x: CGFloat(i)*cellLength, y: 0)
                size = CGSize(width: cellLength, height: newFrame.size.height)
                break;
            case .Vertical:
                pos = CGPoint(x: 0, y: CGFloat(i)*cellLength)
                size = CGSize(width: newFrame.size.width, height: cellLength)
                break;
            }
            
//            let numLayers : Int = 0
            
            let cell = LineSegmentCell(frame: CGRect(origin: pos, size: size), _id: i)
            
            if(activeCells.contains(i)){
                if(cell.awake == false){
                    if let layer = layers[i]{
                        cell.wake(layers: layer)
                    }else{
                        cell.wake(layers: 1)
                    }
                }
            }
            
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 0.5
            self.addSubview(cell)
            cells.append(cell)
        }
        
        self.frame.origin = Screen.screenPos(x: -1, y: 0)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LineSegmentCell : SegmentCell{
    
}
