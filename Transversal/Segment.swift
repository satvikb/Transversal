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
    var layers : [Int:Int] = [:]
    var numCells : Int!;
    
    var inScreenPosition : CGPoint!;
    
    var hiddenAlpha : Bool = false
    
    var timePerCell : Double = 0.1
    
    init(frame: CGRect, _id : Int, _numCells : Int, _activeCells : [Int], _layers:[Int:Int]){
        id = _id
        numCells = _numCells
        activeCells = _activeCells
        layers = _layers
        
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
    
    func numActiveCell() -> Int{
        var num = 0
        for cell in cells{
            if(cell.awake == true){
                num += 1
            }
        }
        return num
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
    
    func hide(time: TimeInterval){
        hiddenAlpha = true
        UIView.animate(withDuration: time, animations: {
            self.alpha = 0
        })
    }
    
    func show(time: TimeInterval){
        hiddenAlpha = false
        UIView.animate(withDuration: time, animations: {
            self.alpha = 1
        })
    }
}

protocol SegmentCellProtocol {
    func setColor(color:UIColor)
}

class SegmentCell : UIView{
    
    var id: Int!;
    var awake : Bool = false
    var layers : Int = 1
    
    var transversing : Bool = false
    
    var currentColor : UIColor!;
    
    init(frame: CGRect, _id: Int){
        super.init(frame: frame)
        id = _id
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func wake(layers: Int = 1){
        self.layers = layers
        let color = ColorScheme.colorForLayer(layer: layers)
        setColor(color: color)
        currentColor = color
        awake = true
    }
    
    func sleep(){
        currentColor = UIColor.clear
        setColor(color: UIColor.clear)
        awake = false
    }
    
    //return if cell is active when hit
    func hit() -> Bool{
        if(awake){
            if layers > 0{
                layers -= 1
                
                if(layers == 0){
                    sleep()
                }else{
                    currentColor = ColorScheme.colorForLayer(layer: layers)
                    setColor(color: currentColor)
                }
                return true
            }else{
                sleep()
                return false
            }
        }else{
            return false
        }
    }
    
    func setTransversing(isTransversing: Bool, color: UIColor = UIColor.white){
        transversing = isTransversing
        
        if(isTransversing == true){
            setColor(color: color)
        }else{
            if(awake){
                setColor(color: currentColor)
            }else{
                setColor(color: UIColor.clear)
            }
        }
    }
    
    func setColor(color: UIColor){
        self.layer.backgroundColor = color.cgColor
    }
}
