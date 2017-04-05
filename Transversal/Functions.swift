//
//  Functions.swift
//  Transversal
//
//  Created by Satvik Borra on 4/3/17.
//  Copyright © 2017 sborra. All rights reserved.
//

import UIKit

class Functions{
    
    static func getRandomColor(alpha : CGFloat = 1.0) -> UIColor {
        let r : CGFloat = CGFloat(randomInt(min: 70, max: 200))
        let g : CGFloat = CGFloat(randomInt(min: 70, max: 200))
        let b : CGFloat = CGFloat(randomInt(min: 70, max: 200))
        return UIColor(red: 1-(r/255), green: 1-(g/255), blue: 1-(b/255), alpha: alpha)
    }
    
    static func darkerColor(of color : UIColor) -> UIColor{
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        return UIColor(hue: hue, saturation: 0.8, brightness: 0.2, alpha: alpha)
    }
    
    static func similarColors(col1: UIColor, col2: UIColor, tolerance: CGFloat = 0.05) -> Bool{
        let red : Bool = (abs(col1.components.red - col2.components.red)) <= tolerance
        let green : Bool = (abs(col1.components.green - col2.components.green)) <= tolerance
        let blue : Bool = (abs(col1.components.blue - col2.components.blue)) <= tolerance
        if(red == true || green == true || blue == true){
            return true
        }
        return false
    }
    
    static func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    static func randomFloat(minimum: CGFloat, maximum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(minimum - maximum) + min(minimum, maximum)
    }
    
    static func lerpf(a : CGFloat, b : CGFloat, t : CGFloat) -> CGFloat{
        return a + (b - a) * t;
    }
    
    static func lerpColor(a : UIColor, b : UIColor, t : CGFloat) -> UIColor{
        let c = UIColor(colorLiteralRed: Float(lerpf(a: CGFloat(a.components.red), b: CGFloat(b.components.red), t: t)), green: Float(lerpf(a: CGFloat(a.components.green), b: CGFloat(b.components.green), t: t)), blue: Float(lerpf(a: CGFloat(a.components.blue), b: CGFloat(b.components.blue), t: t)), alpha: Float(lerpf(a: CGFloat(a.components.alpha), b: CGFloat(b.components.alpha), t: t)));
        
        return c;
    }
    
}

extension UIColor {
    var components:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r,g,b,a)
    }
}
