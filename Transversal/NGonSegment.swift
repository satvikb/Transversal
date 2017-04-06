//
//  NGonSegment.swift
//  Transversal
//
//  Created by Satvik Borra on 4/5/17.
//  Copyright © 2017 sborra. All rights reserved.
//

import UIKit

class NGonSegment : Segment{
    
    var numSides : Int!
    var cellsPerSide : Int!
    var totalCells : Int!
    
    init(frame: CGRect, _id: Int, _numSides : Int, _cellsPerSide: Int, _activeCells : [Int], innerRadius : CGFloat, outerRadius : CGFloat){
        var newFrame = frame
        let largest = max(frame.size.width, frame.size.height)
        newFrame.size.width = largest
        newFrame.size.height = largest
        
        numSides = _numSides
        cellsPerSide = _cellsPerSide
        totalCells = _numSides * _cellsPerSide
        
        super.init(frame: newFrame, _id: _id, _numSegments: totalCells, _activeCells: _activeCells)
        
        let actualInnerRadius = innerRadius*largest
        let actualOuterRadius = outerRadius*largest
        
        inScreenPosition = newFrame.origin
        
        for i in 0...numSegments-1 {
            let pos : CGPoint! = CGPoint.zero;
            let size : CGSize! = newFrame.size;
            
            let cell = NGonSegmentCell(frame: CGRect(origin: pos, size: size), _i: i, r1: actualInnerRadius, r2: actualOuterRadius, numSides: _numSides, cellsPerSide: _cellsPerSide)
            
            if(activeCells.contains(i)){
                if(cell.awake == false){
                    cell.wake(color: UIColor.red)
                }
            }
            
            self.addSubview(cell)
            cells.append(cell)
        }
        
//        self.layer.borderWidth = 1
        
//        let circleRadians = CGFloat.pi*2
//        let perSegmentAngle = circleRadians/CGFloat(_numSides)
        self.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
        
        self.frame.origin = Screen.screenPos(x: -1, y: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class NGonSegmentCell : SegmentCell{
    
    var segmentShape : CAShapeLayer!
    
    init(frame: CGRect, _i: Int, r1 : CGFloat, r2 : CGFloat, numSides : Int, cellsPerSide : Int) {
        super.init(frame: frame, _id: _i)
        
        segmentShape = CAShapeLayer()
        segmentShape.path = ngonSegment(r1: r1, r2: r2, i: _i, numSides: numSides, cellsPerSide: cellsPerSide).cgPath
        segmentShape.strokeColor = UIColor.white.cgColor
        segmentShape.fillColor = UIColor.clear.cgColor
        
        
        self.layer.addSublayer(segmentShape)
    }
    
    
    // TODO
    // Input 4 different arguments
    //  Height, Width
    //  Inner Radius, Outer Radius
    //
    // Implement cellsPerSide
    func ngonSegment(r1:CGFloat, r2:CGFloat, i:Int, numSides:Int, cellsPerSide:Int) -> UIBezierPath{
        let center = CGPoint(x: frame.origin.x + frame.size.width/2, y: frame.origin.y+frame.size.height/2)
        let circleRadians = CGFloat.pi*2
        
        let perSegmentAngle = circleRadians/CGFloat(numSides)
        
        let startAngle : CGFloat = (CGFloat(i))*perSegmentAngle
        let endAngle : CGFloat = (CGFloat(i+1))*perSegmentAngle
        
        let path = UIBezierPath()
        
        let startPointInner = CGPoint(x: center.x + cos(startAngle)*r1/2, y: center.y + sin(startAngle)*r1/2)
        path.move(to: startPointInner)
        
        let endPointInner = CGPoint(x: center.x + cos(endAngle)*r1/2, y: center.y + sin(endAngle)*r1/2)
        path.addLine(to: endPointInner)

        let startPointOuter = CGPoint(x: center.x + cos(endAngle)*r2/2, y: center.y + sin(endAngle)*r2/2)
        path.addLine(to: startPointOuter)
        
        let endPointOuter = CGPoint(x: center.x + cos(startAngle)*r2/2, y: center.y + sin(startAngle)*r2/2)
        path.addLine(to: endPointOuter)
        
        path.close()
        
        
//        let rotation = CGAffineTransform(rotationAngle: perSegmentAngle)
//        path.apply(rotation)
        
        return path
    }
    
    override func setTransversing(isTransversing: Bool, color: UIColor) {
        super.setTransversing(isTransversing: isTransversing, color: color)
    }
    
    override func setColor(col: UIColor) {
        segmentShape.fillColor = col.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
