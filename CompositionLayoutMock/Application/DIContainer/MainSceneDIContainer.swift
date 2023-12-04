//
//  MainSceneDIContainer.swift
//  CompositionLayoutMock
//
//  Created by JunHyeok Lee on 12/4/23.
//

import UIKit

final class MainSceneDIContainer {
    init() {
        
    }
    
    func makeMainTabBarController() -> MainTabBarController {
        return MainTabBarController(dependencies: self)
    }
}

extension MainSceneDIContainer: MainTabBarControllerDependencies {
    func makeFirstViewController() -> ViewController {
        return ViewController.create()
    }
    
    func makeSecondViewController() -> SecondViewController {
        return SecondViewController.create()
    }
}
