//
//  LevelHandler.swift
//  Transversal
//
//  Created by Satvik Borra on 4/6/17.
//  Copyright © 2017 sborra. All rights reserved.
//

import UIKit

class LevelHandler {

    static var levels = [levelOne, levelTwo]
    
    static func getCurrentLevel() -> Level{
        //TODO Save and load progress
        return clone(level: levels[0])
    }
    
    static func clone(level: Level) -> Level{
        return Level(num: level.levelNum, _segments: level.segments)//level.copy() as! Level
    }
    
    static func getLevel(id : Int) -> Level{
        if levels.count > id {
            return clone(level: levels[id])
        }
        return clone(level: levels[0])
    }

    static func getNextLevel(current:Level) -> Level{
        if(current.levelNum == levels[0].levelNum){
            return clone(level: levels[1])
        }else{
            return clone(level: levels[0])
        }
    }
    
    static var levelOne = Level(num: 0, _segments: [
        LineSegment(frame: Screen.screenRect(x: 0, y: 0.45, width: 1, height: 0.1), _id: 0, _numCells: 10, _activeCells: [7], _layers: [:], dir: .Horizontal, box: true)
        ])
    
//    static var levelTwo = Level(num: 1, _segments: [
//        LineSegment(frame: Screen.screenRect(x: 0, y: 0.45, width: 1, height: 0.1), _id: 0, _numCells: 10, _activeCells: [2], _layers: [:], dir: .Horizontal, box: true)
//        ])
    
    
    static var levelTwo = Level(num: 1, _segments: [
        LineSegment(frame: Screen.screenRect(x: 0, y: 0.25, width: 1, height: 0.02), _id: 0, _numCells: 25, _activeCells: [3, 5, 6, 8, 10, 15, 19, 24], _layers:[5:2, 8:4], dir: .Horizontal),
        LineSegment(frame: Screen.screenRect(x: 0.0, y: 0.3, width: 0.1, height: 0.3), _id: 1, _numCells: 15, _activeCells: [3, 6, 8, 10, 13], _layers:[3:2, 6: 4, 13: 4], dir: .Vertical),
        CircleSegment(frame: Screen.screenRect(x: 0.15, y: 0.3, width: 0.35, height: 0), _id: 2, _numCells: 15, _activeCells: [4, 6, 10, 13], _layers:[10:5], innerRadius: 0.8, outerRadius: 1),
        NGonSegment(frame: Screen.screenRect(x: 0.575, y: 0.325, width: 0.25, height: 0), _id: 3, _numSides: 9, _cellsPerSide: 1, _activeCells: [1, 3], _layers:[3:4], innerRadius: 0.7, outerRadius: 1),
        LineSegment(frame: Screen.screenRect(x: 0.95, y: 0.3, width: 0.1, height: 0.3), _id: 4, _numCells: 15, _activeCells: [4, 6, 9, 12, 14], _layers:[6: 2, 9:2, 12:3], dir: .Vertical),
        LineSegment(frame: Screen.screenRect(x: 0, y: 0.65, width: 1, height: 0.1), _id: 5, _numCells: 20, _activeCells: [5, 8, 11, 14, 17], _layers:[11:2, 17: 5], dir: .Horizontal)
        ])
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
