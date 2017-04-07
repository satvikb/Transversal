//
//  Game.swift
//  Transversal
//
//  Created by Satvik Borra on 4/3/17.
//  Copyright © 2017 sborra. All rights reserved.
//

import UIKit

class Game : Scene {
    
    var currentLevel : Level!
    var transverser : Transverser!
    var cellLeftLabel : Label!;
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        cellLeftLabel = Label(frame: Screen.screenRect(x: 0, y: 0, width: 1, height: 0.1), text: "0", _outPos: Screen.screenPos(x: -1, y: 0.05), _inPos: Screen.screenPos(x: 0, y: 0.05), textColor: UIColor.white, debugFrame: false)
        cellLeftLabel.textAlignment = .center
        cellLeftLabel.font = UIFont(name: fontName, size: Screen.fontSize(fontSize: 5))
        
        
        //init transverser
        transverser = Transverser()
        
        self.addSubview(cellLeftLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.stopButtonPressed()
    }
    
    func updateCellLeftText(){
        cellLeftLabel.text = "\(currentLevel.numActiveCell())"
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
            print("added seg \(seg.id) \(seg.hasActiveCell())")
            seg.animateIn(time: transitionDuration)
            self.addSubview(seg)
        }
        currentLevel = level
        
        updateCellLeftText()
        
        transverser.setLevel(level: level)
        transverser.start()
    }
    
    func removeLevel(level: Level){
        for seg in level.segments{
            seg.removeFromSuperview()
        }
    }
    
    override func animateIn() {
        cellLeftLabel.animateIn(time: transitionDuration)
        
        let level = LevelHandler.getCurrentLevel()
        
        loadLevel(level: level)
        transverser.setLevel(level: level)
        
        updateCellLeftText()
    }
    
    override func animateOut() {
        cellLeftLabel.animateOut(time: transitionDuration)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
