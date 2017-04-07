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
    
    init(frame: CGRect, _id: Int, _numSides : Int, _cellsPerSide: Int, _activeCells : [Int], _layers:[Int:Int], innerRadius : CGFloat, outerRadius : CGFloat){
        var newFrame = frame
        let largest = max(frame.size.width, frame.size.height)
        newFrame.size.width = largest
        newFrame.size.height = largest
        
        numSides = _numSides
        cellsPerSide = _cellsPerSide
        totalCells = _numSides * _cellsPerSide
        
        super.init(frame: newFrame, _id: _id, _numCells: totalCells, _activeCells: _activeCells, _layers: _layers)
        
        let actualInnerRadius = innerRadius*largest
        let actualOuterRadius = outerRadius*largest
        
        inScreenPosition = newFrame.origin
        
        for i in 0...numSides-1 {
            let pos : CGPoint! = CGPoint.zero;
            let size : CGSize! = newFrame.size;
            
            for k in 0...cellsPerSide-1 {
                let cell = NGonSegmentCell(frame: CGRect(origin: pos, size: size), _i: i, r1: actualInnerRadius, r2: actualOuterRadius, numSides: _numSides, cellsPerSide: _cellsPerSide, cellSideI: k)
                
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
    
    init(frame: CGRect, _i: Int, r1 : CGFloat, r2 : CGFloat, numSides : Int, cellsPerSide : Int, cellSideI: Int) {
        super.init(frame: frame, _id: _i)
        
        segmentShape = CAShapeLayer()
        segmentShape.path = ngonSegment(r1: r1, r2: r2, i: _i, numSides: numSides, cellsPerSide: cellsPerSide, cellSideI: cellSideI).cgPath
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
    func ngonSegment(r1:CGFloat, r2:CGFloat, i:Int, numSides:Int, cellsPerSide:Int = 1, cellSideI : Int = 0) -> UIBezierPath{
        let center = CGPoint(x: frame.origin.x + frame.size.width/2, y: frame.origin.y+frame.size.height/2)
        let circleRadians = CGFloat.pi*2
        
        let totalCells = numSides*cellsPerSide
        
        let perSegmentAngle = circleRadians/CGFloat(totalCells)

        
        let overallCellI = (i*cellsPerSide)+cellSideI
        let startAngle : CGFloat = (CGFloat(overallCellI))*perSegmentAngle
        let endAngle : CGFloat = (CGFloat(overallCellI+1))*perSegmentAngle
        
        let path = UIBezierPath()
        
        let ir = r1/2
        let or = r2/2
        
//        let innerXDifference = abs((cos(endAngle)*ir)-(cos(startAngle)*ir))/CGFloat(cellsPerSide)
//        let innerYDifference = abs((sin(endAngle)*ir)-(sin(startAngle)*ir))/CGFloat(cellsPerSide)
//        
//        let outerXDifference = abs((cos(endAngle)*or)-(cos(startAngle)*or))/CGFloat(cellsPerSide)
//        let outerYDifference = abs((sin(endAngle)*or)-(sin(startAngle)*or))/CGFloat(cellsPerSide)
//        
//        let n = CGFloat(cellSideI+1)
//        
//        let start = CGPoint(x: center.x + innerXDifference*n, y: center.y + innerYDifference*n)
//        path.move(to: start)
//        
//        let innerEnd = CGPoint(x: center.x + innerXDifference*(n-1), y: center.y + innerYDifference*(CGFloat(cellsPerSide)-n))
////        path.addLine(to: innerEnd)
//        
//        let outerStart = CGPoint(x: center.x + outerXDifference*(n-1), y: center.y + outerYDifference*(CGFloat(cellsPerSide)-n))
//        path.addLine(to: outerStart)
//        
//        let outerEnd = CGPoint(x: center.x + outerXDifference*n, y: center.y + outerYDifference*n)
////        path.addLine(to: outerEnd)
//        
//        print("\(start) \(innerEnd) \(outerStart) \(outerEnd)")
//        
//        path.close()
        
        
//        if(cellsPerSide == 1){
            let startPointInner = CGPoint(x: center.x + cos(startAngle)*ir, y: center.y + sin(startAngle)*ir)
            path.move(to: startPointInner)
        
            let endPointInner = CGPoint(x: center.x + cos(endAngle)*ir, y: center.y + sin(endAngle)*ir)
            path.addLine(to: endPointInner)
            
            let startPointOuter = CGPoint(x: center.x + cos(endAngle)*or, y: center.y + sin(endAngle)*or)
            path.addLine(to: startPointOuter)
            
            let endPointOuter = CGPoint(x: center.x + cos(startAngle)*or, y: center.y + sin(startAngle)*or)
            path.addLine(to: endPointOuter)
            
            path.close()
//        }else{
        
            
            
            
            
            
            
//            let incrementAngle = (perSegmentAngle/CGFloat(cellsPerSide))
//            
//            let innerCellStartAngle = startAngle+(incrementAngle*CGFloat(cellSideI))
//            let innerCellEndAngle = endAngle+(incrementAngle*CGFloat(cellSideI))
//
//            if(cellSideI == 0){
//                let startPointInner = CGPoint(x: center.x + cos(startAngle)*ir, y: center.y + sin(startAngle)*ir)
//                path.move(to: startPointInner)
//                
//                let endPointInner = CGPoint(x: center.x + cos(startAngle)*(ir/CGFloat(cellsPerSide)), y: center.y + sin(endAngle)*(ir/CGFloat(cellsPerSide)))
//                path.addLine(to: endPointInner)
//                let endPointOuter = CGPoint(x: center.x + cos(startAngle)*(or/CGFloat(cellsPerSide)), y: center.y + sin(endAngle)*(or/CGFloat(cellsPerSide)))
//                path.addLine(to: endPointOuter)
//                
//                let finishPointOuter = CGPoint(x: center.x + cos(startAngle)*or, y: center.y + sin(startAngle)*r2)
//                path.addLine(to: finishPointOuter)
//                
//            }else if(cellSideI == cellsPerSide-1){
//                let startPointInner = CGPoint(x: center.x + cos(innerCellStartAngle)*ir, y: center.y + sin(innerCellStartAngle)*ir)
//                path.move(to: startPointInner)
//                
//                let endPointInner = CGPoint(x: center.x + cos(startAngle)*(ir/CGFloat(cellsPerSide)), y: center.y + sin(endAngle)*(ir/CGFloat(cellsPerSide)))
//                path.addLine(to: endPointInner)
//                let endPointOuter = CGPoint(x: center.x + cos(startAngle)*(or/CGFloat(cellsPerSide)), y: center.y + sin(endAngle)*(or/CGFloat(cellsPerSide)))
//                path.addLine(to: endPointOuter)
//                
//                let finishPointOuter = CGPoint(x: center.x + cos(startAngle)*or, y: center.y + sin(startAngle)*r2)
//                path.addLine(to: finishPointOuter)
//                
//                
//                
//                
//                let startPointInner = CGPoint(x: center.x + cos(innerCellStartAngle)*(ir/CGFloat(cellsPerSide)), y: center.y + sin(innerCellStartAngle)*(ir/CGFloat(cellsPerSide)))
//                path.addLine(to: startPointInner)
//                
//                let endPointInner = CGPoint(x: center.x + cos(innerCellStartAngle)*(ir/cellSideI), y: <#T##CGFloat#>)
//            }else{
//                
//            }
//        }
        
        return path
    }
    
    override func setTransversing(isTransversing: Bool, color: UIColor) {
        super.setTransversing(isTransversing: isTransversing, color: color)
    }
    
    override func setColor(color: UIColor) {
        segmentShape.fillColor = color.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
