//
//  Label.swift
//  Points
//
//  Created by Satvik Borra on 2/1/17.
//  Copyright © 2017 vborra. All rights reserved.
//

import UIKit

class Label: UILabel{
    
    static let Null = Label(frame: CGRect.zero, text: "")
    
    var outPos: CGPoint!
    var inPos: CGPoint!
    
    
    init(frame: CGRect, text: String, _outPos: CGPoint = CGPoint.zero, _inPos: CGPoint = CGPoint.zero, textColor: UIColor = UIColor.white, debugFrame: Bool = false){
        outPos = _outPos
        inPos = _inPos
        
        let newFrame = CGRect(origin: outPos, size: frame.size)
        super.init(frame: newFrame)
        
        if(debugFrame){
            self.layer.borderColor = UIColor.red.cgColor
            layer.borderWidth = 5
        }
        
        adjustsFontSizeToFitWidth = true

        changeTextColor(color: textColor)
        self.text = text
    }
    
    func changeTextColor(color: UIColor){
        textColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateIn(time: TimeInterval){
        UIView.animate(withDuration: time, animations: {
            self.frame.origin = self.inPos
        })
    }
    
    func animateOut(time: TimeInterval){
        UIView.animate(withDuration: time, animations: {
            self.frame.origin = self.outPos
        })
    }
    
}
