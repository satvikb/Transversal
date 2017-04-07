//
//  Transverser.swift
//  Transversal
//
//  Created by Satvik Borra on 4/3/17.
//  Copyright © 2017 sborra. All rights reserved.
//

import UIKit

class Transverser{
    
    var level : Level!
    var currentSegment : Segment!;
    var currentCell : SegmentCell!;
    var updateTimer : CADisplayLink!;
    
    var currentTime : Double!;
//    var timePerCell : Double = 0.1;
    var timePerCellTimer : Double = 0;
    
    init(_level: Level){
        level = _level
        
        currentSegment = level.segments[0]
        currentCell = currentSegment.cells[0]
    }
    
    func getCurrentSegment() -> Segment{
        if(currentSegment != nil){
            return currentSegment
        }else{
            return level.segments[0]
        }
    }
    
    func getCurrentCell() -> SegmentCell{
        if(currentSegment != nil){
            return currentCell
        }else{
            return level.segments[0].cells[0]
        }
    }
    
    var prevTime : Double!;
    
    @objc func update(){
        if(prevTime != nil){
            currentTime = CACurrentMediaTime()
            let delta = currentTime-prevTime
            timePerCellTimer += delta
            
            if(timePerCellTimer > currentSegment.timePerCell){
                if(level.hasActiveCell()){
                    transverse()
                }else{
                    print("No more cells!")
                    currentSegment.hide(time: 2)
                }
            
                timePerCellTimer = 0
            }
            prevTime = CACurrentMediaTime()
        }else{
            prevTime = CACurrentMediaTime()
        }
    }
    
    func transverse(){
        let segmentIndex : Int = level.segments.index(of: currentSegment)!
        let cellIndex : Int = currentSegment.cells.index(of: currentCell)!
//        currentSegment.cells.inde
        if(cellIndex == currentSegment.cells.count-1){
            // sleep current cell
            currentCell.setTransversing(isTransversing: false)
 
            if(currentSegment.hasActiveCell() == false){
                if(currentSegment.hiddenAlpha == false){
                    currentSegment.hide(time: 2)
                }
            }
            
            var foundActiveSegment : Bool = false
            var newSegmentIndex = (segmentIndex + 1)%level.segments.count
            var newSegment = level.segments[newSegmentIndex] // : Segment;
            
            while(foundActiveSegment == false){
                newSegment = level.segments[newSegmentIndex]
                if(newSegment.hasActiveCell() == true){
                    foundActiveSegment = true
                }else{                    
                    newSegmentIndex = (newSegmentIndex + 1)%level.segments.count
                }
            }
            currentSegment = newSegment
            
            currentCell = currentSegment.cells[0]
            currentCell.setTransversing(isTransversing: true)
        }else{
            // next cell
            currentCell.setTransversing(isTransversing: false)
            let newCellIndex : Int = cellIndex + 1
            let newCell = currentSegment.cells[newCellIndex]
            newCell.setTransversing(isTransversing: true)
            currentCell = newCell
        }
    }
    
    func switchLevel(level: Level){
        print("TODO")
    }
    
    func start(){
        updateTimer = CADisplayLink(target: self, selector: #selector(self.update))
        updateTimer.preferredFramesPerSecond = 60
        updateTimer.add(to: RunLoop.current, forMode: RunLoopMode.commonModes)
    }
    
    func resume(){
        updateTimer.isPaused = false
    }
    
    func pause(){
        updateTimer.isPaused = true
    }
    
    func stop(){
        updateTimer.isPaused = true
        updateTimer.remove(from: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
        updateTimer = nil
    }
}
