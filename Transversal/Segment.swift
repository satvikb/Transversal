//
//  Segment.swift
//  Transversal
//
//  Created by Satvik Borra on 4/3/17.
//  Copyright © 2017 sborra. All rights reserved.
//

import UIKit

enum SegmentShape {
    case Vertical;
    case Horizontal;
    
    case Circle;
    case NGon;
}

class Segment : UIView {
    
    var id : Int!;
    var cells : [SegmentCell] = [];
    var activeCells : [Int] = []
    var numSegments : Int!;
    
    var inScreenPosition : CGPoint!;
    
    init(frame: CGRect, _id : Int, _numSegments : Int, _activeCells : [Int]){
        id = _id
        numSegments = _numSegments
        activeCells = _activeCells
        
        super.init(frame: frame)
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
        self.layer.backgroundColor = col.cgColor
    }
}
