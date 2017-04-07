//
//  MainMenu.swift
//  Transversal
//
//  Created by Satvik Borra on 4/3/17.
//  Copyright © 2017 sborra. All rights reserved.
//

import UIKit

class MainMenu : Scene {
    
    var playButton : SuperButton!
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        playButton = SuperButton(_posHandler: PositionHandler(inPosProp: Proportion(_x: 0.25, _y: 0.45), outPosProp: Proportion(_x: -0.5, _y: 0.45)), propSize: CGSize(width: 0.5, height: 0.1), text: "Play")
        
        playButton.touchUp = {
            GameHandler.switchScene(from: .MainMenu, to: .Game)
        }
        
        self.addSubview(playButton)
    }
    
    override func animateIn() {
        playButton.animateIn(time: transitionDuration)
    }
    
    override func animateOut() {
        playButton.animateOut(time: transitionDuration)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
