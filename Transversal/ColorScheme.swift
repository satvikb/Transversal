//
//  ColorScheme.swift
//  Transversal
//
//  Created by Satvik Borra on 4/6/17.
//  Copyright © 2017 sborra. All rights reserved.
//

import UIKit

class ColorScheme{
    
    
    
    static let colorScheme : [Int : UIColor] = [0:UIColor.clear, 1:UIColor.red, 2:UIColor.blue, 3:UIColor.green, 4:UIColor.orange, 5:UIColor.yellow, 6:UIColor.purple, 7:UIColor.magenta]
    
    
    static func colorForLayer(layer: Int) -> UIColor{
        if let color = ColorScheme.colorScheme[layer]{
            return color
        }else{
            return UIColor.brown
        }
    }
    
    
    
    
    
    static func getRandomColor(alpha : CGFloat = 1.0) -> UIColor {
        let r : CGFloat = CGFloat(Functions.randomInt(min: 70, max: 200))
        let g : CGFloat = CGFloat(Functions.randomInt(min: 70, max: 200))
        let b : CGFloat = CGFloat(Functions.randomInt(min: 70, max: 200))
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

    static func lerpColor(a : UIColor, b : UIColor, t : CGFloat) -> UIColor{
        let c = UIColor(colorLiteralRed: Float(lerpf(a: CGFloat(a.components.red), b: CGFloat(b.components.red), t: t)), green: Float(lerpf(a: CGFloat(a.components.green), b: CGFloat(b.components.green), t: t)), blue: Float(lerpf(a: CGFloat(a.components.blue), b: CGFloat(b.components.blue), t: t)), alpha: Float(lerpf(a: CGFloat(a.components.alpha), b: CGFloat(b.components.alpha), t: t)));
        
        return c;
    }
    
    static func lerpf(a : CGFloat, b : CGFloat, t : CGFloat) -> CGFloat{
        return a + (b - a) * t;
    }
}
