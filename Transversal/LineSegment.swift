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
//                pos = CGPoint(x: CGFloat(i)*cellLength, y: 0)
                size = CGSize(width: cellLength, height: newFrame.size.height)
                break;
            case .Vertical:
//                pos = CGPoint(x: 0, y: CGFloat(i)*cellLength)
                size = CGSize(width: newFrame.size.width, height: cellLength)
                break;
            }
            
            
            let cell = LineSegmentCell(frame: CGRect(origin: pos, size: size), _i: i, _dir: dir, _cellLength: cellLength)
            
            if(activeCells.contains(i)){
                if(cell.awake == false){
                    if let layer = layers[i]{
                        cell.wake(layers: layer)
                    }else{
                        cell.wake(layers: 1)
                    }
                }
            }
            
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
    
    var segmentShape : CAShapeLayer!
    
    init(frame: CGRect, _i:Int, _dir: LineSegmentDirection, _cellLength : CGFloat){
        super.init(frame: frame, _id: _i)
        
        segmentShape = CAShapeLayer()
        segmentShape.path = boxSegment(width: frame.size.width, height: frame.size.height, i: _i, _dir: _dir, _cellLength: _cellLength).cgPath
        segmentShape.strokeColor = UIColor.white.cgColor
        segmentShape.fillColor = UIColor.clear.cgColor
        
        self.layer.addSublayer(segmentShape)
    }
    
    func boxSegment(width:CGFloat, height:CGFloat, i:Int, _dir: LineSegmentDirection, _cellLength: CGFloat) -> UIBezierPath{
        
        let pos : CGPoint!
        
        switch _dir {
        case .Horizontal:
            pos = CGPoint(x: CGFloat(i)*_cellLength, y: 0)
            break;
        case .Vertical:
            pos = CGPoint(x: 0, y: CGFloat(i)*_cellLength)
            break;
            
        }
        
        let path = UIBezierPath(rect: CGRect(x: pos.x, y: pos.y, width: _cellLength, height: _cellLength))
        return path
    }
    
    override func setColor(color: UIColor) {
        segmentShape.fillColor = color.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
