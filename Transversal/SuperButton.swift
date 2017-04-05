//
//  SuperButton.swift
//  Transversal
//
//  Created by Satvik Borra on 4/3/17.
//  Copyright © 2017 sborra. All rights reserved.
//

import UIKit

class SuperButton : UIView{
    
    var posHandler : PositionHandler!;
    
    var button : UIButton!;
    var shadowView : UIView!;
    
    let shadowAmount : CGFloat = 15
    var shadowPos : CGPoint! //    var pos = Screen.screenPos(x: 0.1, y: 0.2)

    init(_posHandler : PositionHandler, propSize: CGSize, text : String = ""){
        posHandler = _posHandler
        let frame : CGRect = CGRect(origin: posHandler.getActualOutOfScreenPosition(), size: Screen.screenSize(width: propSize.width, height: propSize.height))
        
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        shadowPos = CGPoint(x: 0, y: shadowAmount)
        print("\(shadowPos)")
        button = UIButton(type: .custom)
        button.frame = CGRect(origin: CGPoint.zero, size: frame.size)
//        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.backgroundColor = UIColor.blue
        button.setTitle(text, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: fontName, size: Screen.fontSize(fontSize: 2))
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(buttonTouchUpFunc(sender:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonTouchUpFunc(sender:)), for: .touchUpOutside)
        button.addTarget(self, action: #selector(buttonTouchDownFunc(sender:)), for: .touchDown)
        button.isUserInteractionEnabled = true
        
        shadowView = UIView(frame: CGRect(origin: shadowPos, size: frame.size))
//        shadowView.layer.cornerRadius = 0.5 * button.bounds.size.width
        shadowView.backgroundColor = UIColor(red: 0, green: 0, blue: 0.5, alpha: 1)
        
        self.addSubview(shadowView)
        self.addSubview(button)
        
        bringSubview(toFront: button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTouchUpFunc(sender: UIButton){
        button.frame.origin = CGPoint.zero
        touchUp()
    }
    
    @objc func buttonTouchDownFunc(sender: UIButton){
        button.frame.origin = shadowPos
        touchDown()
    }
    
    func animateIn(time: TimeInterval){
        UIView.animate(withDuration: time, animations: {
            self.frame.origin = self.posHandler.getActualInScreenPosition()
        })
    }
    
    func animateOut(time: TimeInterval){
        UIView.animate(withDuration: time, animations: {
            self.frame.origin = self.posHandler.getActualOutOfScreenPosition()
        })
    }
    
    var touchDown = {}
    var touchUp = {}
}
