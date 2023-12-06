//
//  MainTabBarController.swift
//  CompositionLayoutMock
//
//  Created by JunHyeok Lee on 12/4/23.
//

import UIKit

protocol MainTabBarControllerDependencies {
    func makeFirstViewController() -> BaseCompositionLayoutController
    func makeSecondViewController() -> SupplementaryViewController
    func makeThirdViewController() -> BadgeViewController
    func makeFourthViewController() -> VerticalCollectionViewController
}

final class MainTabBarController: UITabBarController {
    
    private let dependencies: MainTabBarControllerDependencies
    
    init(dependencies: MainTabBarControllerDependencies) {
        self.dependencies = dependencies
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    private func setupTabs() {
        let firstTab = UINavigationController(rootViewController: dependencies.makeFirstViewController())
        firstTab.tabBarItem = UITabBarItem(title: "Base", image: nil, selectedImage: nil)
        
        let secondTab = UINavigationController(rootViewController: dependencies.makeSecondViewController())
        secondTab.tabBarItem = UITabBarItem(title: "Header/Footer\nSideView", image: nil, selectedImage: nil)
        
        let thirdTab = UINavigationController(rootViewController: dependencies.makeThirdViewController())
        thirdTab.tabBarItem = UITabBarItem(title: "DecorationView\nBadge", image: nil, selectedImage: nil)
        
        let fourthTab = UINavigationController(rootViewController: dependencies.makeFourthViewController())
        fourthTab.tabBarItem = UITabBarItem(title: "orthogonalScrolling", image: nil, selectedImage: nil)
        
        self.viewControllers = [
            firstTab,
            secondTab,
            thirdTab,
            fourthTab
        ]
    }
}
