//
//  Segment.swift
//  Transversal
//
//  Created by Satvik Borra on 4/3/17.
//  Copyright © 2017 sborra. All rights reserved.
//

import UIKit

enum SegmentDirection {
    case Vertical;
    case Horizontal;
}

class Segment : UIView {
    
    var id : Int!;
    var cells : [SegmentCell] = [];
    var cellMatches : [Int] = []
    var numSegments : Int!;
    
    var inScreenPosition : CGPoint!;
    
    init(frame: CGRect, _id : Int, _numSegments : Int, _cellMatches : [Int], dir : SegmentDirection = .Horizontal, box: Bool = true){
        id = _id
        
        numSegments = _numSegments
        cellMatches = _cellMatches
        
        var cellLength : CGFloat!;
        
        switch dir {
        case .Horizontal:
            cellLength = CGFloat(frame.size.width)/CGFloat(numSegments)
            break;
        case .Vertical:
            cellLength = CGFloat(frame.size.height)/CGFloat(numSegments)
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
        
        super.init(frame: newFrame)

        inScreenPosition = newFrame.origin
        
        for i in 0...numSegments-1 {
            var pos : CGPoint!;
            var size : CGSize!;
            
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
            
            
            let cell = SegmentCell(frame: CGRect(origin: pos, size: size), _id: i)
            
            if(cellMatches.contains(i)){
                if(cell.awake == false){
                    cell.wake(color: UIColor.red)
                }
            }
            
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 0.5
            self.addSubview(cell)
            cells.append(cell)
        }
        
        self.frame.origin = Screen.screenPos(x: -1, y: 0)
    }
    
    func hasActiveCell() -> Bool{
        var hasActive = false
        for cell in cells{
            if(cell.awake == true){
                hasActive = true
            }
        }
        return hasActive
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateIn(time: TimeInterval){
        UIView.animate(withDuration: time, animations: {
            self.frame.origin = self.inScreenPosition
        })
    }
    
    func animateOut(time: TimeInterval){
        UIView.animate(withDuration: time, animations: {
            self.frame.origin = Screen.screenPos(x: -1, y: 0)
        })
    }
}

class SegmentCell : UIView{
    
    var id: Int!;
    var awake : Bool = false
    var transversing : Bool = false
    
    var awakeColor : UIColor!;
    
    init(frame: CGRect, _id: Int){
        super.init(frame: frame)
        id = _id
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func wake(color: UIColor){
        setColor(col: color)
        awakeColor = color
        awake = true
    }
    
    func sleep(){
        setColor(col: UIColor.clear)
        awake = false
    }
    
    func setTransversing(isTransversing: Bool, color: UIColor = UIColor.gray){
        transversing = isTransversing
        
        if(isTransversing == true){
            setColor(col: color)
        }else{
            if(awake){
                setColor(col: awakeColor)
            }else{
                setColor(col: UIColor.clear)
            }
        }
    }
    
    func setColor(col: UIColor){
        self.backgroundColor = col
    }
}
