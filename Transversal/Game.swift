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
    
    var cellLeftLabel : Label!;
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        cellLeftLabel = Label(frame: Screen.screenRect(x: 0, y: 0, width: 1, height: 0.1), text: "0", _outPos: Screen.screenPos(x: -1, y: 0.05), _inPos: Screen.screenPos(x: 0, y: 0.05), textColor: UIColor.white, debugFrame: false)
        cellLeftLabel.textAlignment = .center
        cellLeftLabel.font = UIFont(name: fontName, size: Screen.fontSize(fontSize: 5))
        
        
        stopButton = SuperButton(_posHandler: PositionHandler(inPosProp: Proportion(_x: 0, _y: 0.85), outPosProp: Proportion(_x: -1, _y: 0.85)), propSize: CGSize(width: 1, height: 0.1), text: "Stop")
        
        stopButton.touchDown = {
//            self.stopButtonPressed()
        }
        
        testLevel = Level(num: 0, _segments: [
            LineSegment(frame: Screen.screenRect(x: 0, y: 0.25, width: 1, height: 0.02), _id: 0, _numCells: 25, _activeCells: [0, 3, 6, 8, 10, 15, 19, 24], _layers:[0:2], dir: .Horizontal),
            LineSegment(frame: Screen.screenRect(x: 0, y: 0.3, width: 1, height: 0.1), _id: 1, _numCells: 20, _activeCells: [0, 3, 7, 13, 17], _layers:[0:2], dir: .Horizontal),
            LineSegment(frame: Screen.screenRect(x: 0.0, y: 0.5, width: 0.1, height: 0.3), _id: 2, _numCells: 15, _activeCells: [0, 2, 5, 7, 9, 10, 14], _layers:[2:3], dir: .Vertical),
            CircleSegment(frame: Screen.screenRect(x: 0.15, y: 0.5, width: 0.35, height: 0), _id: 3, _numCells: 15, _activeCells: [4, 6, 10, 13], _layers:[10:5], innerRadius: 0.8, outerRadius: 1),
            NGonSegment(frame: Screen.screenRect(x: 0.575, y: 0.525, width: 0.25, height: 0), _id: 4, _numSides: 9, _cellsPerSide: 1, _activeCells: [1, 3], _layers:[3:4], innerRadius: 0.7, outerRadius: 1),
            LineSegment(frame: Screen.screenRect(x: 0.95, y: 0.5, width: 0.1, height: 0.3), _id: 5, _numCells: 15, _activeCells: [0, 2, 5, 7, 9, 10, 14], _layers:[0:2], dir: .Vertical)
        ])

        //init transverser
        transverser = Transverser(_level: testLevel)
        
//        self.addSubview(stopButton)
        self.addSubview(cellLeftLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.stopButtonPressed()
    }
    
    func updateCellLeftText(){
        cellLeftLabel.text = "\(testLevel.numActiveCell())"
    }
    
    func stopButtonPressed(){
        if(transverser.currentCell.hit() == true){
            updateCellLeftText()
        }else{
            print("Lose life!!")
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
            // animate out segments?
            seg.removeFromSuperview()
        }
    }
    
    override func animateIn() {
        cellLeftLabel.animateIn(time: transitionDuration)
        stopButton.animateIn(time: transitionDuration)
        loadLevel(level: testLevel)
        updateCellLeftText()
    }
    
    override func animateOut() {
        stopButton.animateOut(time: transitionDuration)
        cellLeftLabel.animateOut(time: transitionDuration)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
