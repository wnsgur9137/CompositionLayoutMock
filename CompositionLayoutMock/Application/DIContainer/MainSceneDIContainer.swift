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
    func makeFirstViewController() -> BaseCompositionLayoutController {
        return BaseCompositionLayoutController.create()
    }
    
    func makeSecondViewController() -> SupplementaryViewController {
        return SupplementaryViewController.create()
    }
    
    func makeThirdViewController() -> BadgeViewController {
        return BadgeViewController.create()
    }
    
    func makeFourthViewController() -> VerticalCollectionViewController {
        return VerticalCollectionViewController.create()
    }
}
