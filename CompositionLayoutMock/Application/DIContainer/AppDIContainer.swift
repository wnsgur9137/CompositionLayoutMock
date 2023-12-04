//
//  AppDIContainer.swift
//  CompositionLayoutMock
//
//  Created by JunHyeok Lee on 12/4/23.
//

import Foundation

final class AppDIContainer {
    func makeMainSceneDIContainer() -> MainSceneDIContainer {
        return MainSceneDIContainer()
    }
}
