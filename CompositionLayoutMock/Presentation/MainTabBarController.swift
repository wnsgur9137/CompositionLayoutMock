//
//  MainTabBarController.swift
//  CompositionLayoutMock
//
//  Created by JunHyeok Lee on 12/4/23.
//

import UIKit

protocol MainTabBarControllerDependencies {
    func makeFirstViewController() -> ViewController
    func makeSecondViewController() -> SecondViewController
}

final class MainTabBarController: UITabBarController {
    
    private let dependencies: MainTabBarControllerDependencies
    
    init(dependencies: MainTabBarControllerDependencies) {
        self.dependencies = dependencies
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupTabs() {
        let firstTab = UINavigationController(rootViewController: dependencies.makeFirstViewController())
        firstTab.tabBarItem = UITabBarItem(title: "First", image: nil, selectedImage: nil)
        
        let secondTab = UINavigationController(rootViewController: dependencies.makeSecondViewController())
        secondTab.tabBarItem = UITabBarItem(title: nil, image: nil, selectedImage: nil)
        
        self.viewControllers = [
            firstTab,
            secondTab
        ]
    }
}
