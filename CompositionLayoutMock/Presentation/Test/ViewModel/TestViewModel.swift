//
//  TestViewModel.swift
//  CompositionLayoutMock
//
//  Created by JunHyeok Lee on 7/25/24.
//

import Foundation

enum TestSection: Int, CaseIterable {
    case header
    case vote
    case history
    case charge
    case communityBanner
    case community
}

final class TestViewModel {
    var voteData: [String] = []
    
}

extension TestViewModel: TestDataSource {
    
}
