//
//  CircleSegment.swift
//  Transversal
//
//  Created by Satvik Borra on 4/5/17.
//  Copyright © 2017 sborra. All rights reserved.
//

import UIKit

class CircleSegment : Segment{
    
    init(frame: CGRect, _id: Int, _numCells : Int, _activeCells : [Int], _layers:[Int:Int], innerRadius : CGFloat, outerRadius : CGFloat){
        var newFrame = frame
        let largest = max(frame.size.width, frame.size.height)
        newFrame.size.width = largest
        newFrame.size.height = largest
        
        super.init(frame: newFrame, _id: _id, _numCells: _numCells, _activeCells: _activeCells, _layers:_layers)
        
        let actualInnerRadius = innerRadius*largest
        let actualOuterRadius = outerRadius*largest
        
        inScreenPosition = newFrame.origin
        
        for i in 0...numCells-1 {
            let pos : CGPoint! = CGPoint.zero;
            let size : CGSize! = newFrame.size;
            
            let cell = CircleSegmentCell(frame: CGRect(origin: pos, size: size), _i: i, r1: actualInnerRadius, r2: actualOuterRadius, totalSegments: _numCells)
            
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
        
//        self.layer.borderWidth = 1
        //        let circleRadians = CGFloat.pi*2
//        let perSegmentAngle = circleRadians/CGFloat(_numSegments)
//        self.transform = CGAffineTransform(rotationAngle: perSegmentAngle)
        self.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)

        self.frame.origin = Screen.screenPos(x: -1, y: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CircleSegmentCell : SegmentCell{
    
    var segmentShape : CAShapeLayer!

    init(frame: CGRect, _i: Int, r1 : CGFloat, r2 : CGFloat, totalSegments : Int) {
        super.init(frame: frame, _id: _i)
        
        segmentShape = CAShapeLayer()
        segmentShape.path = circleSegment(r1: r1, r2: r2, i: _i, totalSegments: totalSegments).cgPath
        segmentShape.strokeColor = UIColor.white.cgColor
        segmentShape.fillColor = UIColor.clear.cgColor

        segmentShape.actions = ["onOrderIn": NSNull(), "onOrderOut":NSNull(), "contents":NSNull()]

        
        self.layer.addSublayer(segmentShape)
    }
    
    func circleSegment(r1:CGFloat, r2:CGFloat, i:Int, totalSegments:Int) -> UIBezierPath{
        let center = CGPoint(x: frame.origin.x + frame.size.width/2, y: frame.origin.y+frame.size.height/2)
        let circleRadians = CGFloat.pi*2
        let perSegmentAngle = circleRadians/CGFloat(totalSegments)
        
        let startAngle : CGFloat = (CGFloat(i))*perSegmentAngle
        let endAngle : CGFloat = (CGFloat(i+1))*perSegmentAngle

        let path = UIBezierPath()
        
        path.addArc(withCenter: center, radius: r1/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)

        //No need to do this manually, apparently when adding arc #2 it draws the line automatically
//        let xPos1 = cos(endAngle)*r2
//        let yPos1 = sin(endAngle)*r2
//        path.addLine(to: CGPoint(x: center.x + xPos1, y: center.y + yPos1))
        
        path.addArc(withCenter: center, radius: r2/2, startAngle: endAngle, endAngle: startAngle, clockwise: false)
        
        path.close()
        
        return path
    }
    
    override func setTransversing(isTransversing: Bool, color: UIColor) {
        super.setTransversing(isTransversing: isTransversing, color: color)
    }
    
    override func setColor(color: UIColor) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        segmentShape.fillColor = color.cgColor
        CATransaction.commit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
