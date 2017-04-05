//
//  Game.swift
//  Transversal
//
//  Created by Satvik Borra on 4/3/17.
//  Copyright © 2017 sborra. All rights reserved.
//

import UIKit

class Game : Scene {
    
    var stopButton : SuperButton!
    var currentLevel : Level!
    
    var transverser : Transverser!
    
    var testLevel : Level!
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        stopButton = SuperButton(_posHandler: PositionHandler(inPosProp: Proportion(_x: 0, _y: 0.85), outPosProp: Proportion(_x: -1, _y: 0.85)), propSize: CGSize(width: 1, height: 0.1), text: "Stop")
        
        stopButton.touchDown = {
            self.stopButtonPressed()
        }
        
        testLevel = Level(num: 0, _segments: [
            Segment(frame: Screen.screenRect(x: 0, y: 0.25, width: 1, height: 0.02), _id: 0, _numSegments: 25, _cellMatches: [0, 3, 6, 8, 10, 24], dir: .Horizontal),
            Segment(frame: Screen.screenRect(x: 0, y: 0.3, width: 1, height: 0.1), _id: 1, _numSegments: 20, _cellMatches: [0, 3, 7, 13, 17], dir: .Horizontal),
            Segment(frame: Screen.screenRect(x: 0, y: 0.5, width: 0.1, height: 0.3), _id: 2, _numSegments: 15, _cellMatches: [0, 2, 5, 7, 9, 10, 14], dir: .Vertical),
            Segment(frame: Screen.screenRect(x: 0.9, y: 0.5, width: 0.1, height: 0.3), _id: 2, _numSegments: 15, _cellMatches: [0, 2, 5, 7, 9, 10, 14], dir: .Vertical)
        ])
        

        //init transverser
        transverser = Transverser(_level: testLevel)
        
        self.addSubview(stopButton)
    }
    
    func stopButtonPressed(){
        if(transverser.currentCell.awake == true){
            print("Got one!")
            transverser.currentCell.sleep()
        }
    }
    
    func loadLevel(level : Level){
        if(currentLevel != nil){
            removeLevel(level: currentLevel)
        }
        
        for seg in level.segments{
            print("added seg \(seg.id)")
            seg.animateIn(time: transitionDuration)
            self.addSubview(seg)
        }
        currentLevel = level
        transverser.start()
    }
    
    func removeLevel(level: Level){
        for seg in level.segments{
//            seg.ani
            seg.removeFromSuperview()
        }
    }
    
    override func animateIn() {
        stopButton.animateIn(time: transitionDuration)
        loadLevel(level: testLevel)
    }
    
    override func animateOut() {
        stopButton.animateOut(time: transitionDuration)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
