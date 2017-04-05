//
//  GameHandler.swift
//  Transversal
//
//  Created by Satvik Borra on 4/3/17.
//  Copyright © 2017 sborra. All rights reserved.
//

import UIKit

enum Scenes {
    case Start;
    case MainMenu;
    case Game;
}

class GameHandler {
    
    static var viewController : UIViewController!;
    static var currentScene : Scenes = .Start;
    
    static var mainMenu = MainMenu(frame: Screen.screenRect(x: 0, y: 0, width: 1, height: 1))
    static var game = Game(frame: Screen.screenRect(x: 0, y: 0, width: 1, height: 1))
    
    static func setup(_viewController : UIViewController){
        viewController = _viewController
        viewController.view.addSubview(game)
        viewController.view.addSubview(mainMenu)
    }
    
    static func switchScene(from : Scenes, to: Scenes){
        switch from{
        case .MainMenu:
            mainMenu.animateOut()
            break;
        case .Game:
            game.animateOut()
            break;
        case .Start:
            break;
        }
        
        switch to {
        case .MainMenu:
            mainMenu.animateIn()
            currentScene = .MainMenu
            viewController.view.bringSubview(toFront: mainMenu)
            break;
        case .Game:
            game.animateIn()
            currentScene = .Game
            viewController.view.bringSubview(toFront: game)
            break;
        case .Start:
            break;
        }
        
        
//        currentScene = to
    }
}
