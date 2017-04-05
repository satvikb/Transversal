//
//  Screen.swift
//  Transversal
//
//  Created by Satvik Borra on 4/3/17.
//  Copyright © 2016 Satvik Borra. All rights reserved.
//

import UIKit

var fontName = "Helvetica"
var transitionDuration : TimeInterval = 0.5
var backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)

enum ScreenType{
    case Width;
    case Height;
}

class Screen {
    
    static var heightOverWidth : CGFloat! = 0
    
    static var currentScreenSize : CGRect = UIScreen.main.bounds
    
    static func setup(){
        heightOverWidth = currentScreenSize.height / currentScreenSize.width
    }
    
    static func fontSize(fontSize : CGFloat) -> CGFloat{
        return ((fontSize*heightOverWidth)/1.77866666666667)*currentScreenSize.width/36
    }
    
    static func screenRect(x : CGFloat, y : CGFloat, width : CGFloat, height : CGFloat) -> CGRect{
        return CGRect(origin: screenPos(pos: CGPoint(x: x, y: y)), size: screenSize(width: width, height: height))
    }
    
    static func screenPos(x : CGFloat, y : CGFloat) -> CGPoint{
        return CGPoint(x: scale(float: x, type: .Width), y: scale(float: y, type: .Height))
    }
    
    static func getClampedScreenPosition(x : CGFloat, y : CGFloat) -> CGPoint{
        return CGPoint(x: (x / currentScreenSize.width), y: (y / currentScreenSize.height))
    }
    
    static func screenPos(pos : CGPoint) -> CGPoint{
        return CGPoint(x: scale(float: pos.x, type: .Width), y: scale(float: pos.y, type: .Height))
    }
    
    static func screenSize(width : CGFloat, height : CGFloat) -> CGSize{
        return CGSize(width: width*currentScreenSize.width, height: height*currentScreenSize.height)
    }
    
    static func circleSize(propRadius : CGFloat) -> CGFloat{
        return scale(float: propRadius, type: .Width)
    }
    
    static func scale(float : CGFloat, type : ScreenType) -> CGFloat{
        switch type {
        case .Width:
            return float * currentScreenSize.width
        default:
            return float * currentScreenSize.height
        }
    }
}
