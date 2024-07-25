//
//  TestAdapter.swift
//  CompositionLayoutMock
//
//  Created by JunHyeok Lee on 7/25/24.
//

import UIKit

protocol TestDataSource: AnyObject {
    
}

protocol TestDelegate: AnyObject {
    
}

final class TestAdapter: NSObject {
    private let collectionView: UICollectionView
    private weak var dataSource: TestDataSource?
    private weak var delegate: TestDelegate?
    
    init(collectionView: UICollectionView,
         dataSource: TestDataSource,
         delegate: TestDelegate) {
        
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier)
        collectionView.register(HeaderCell.self, forCellWithReuseIdentifier: HeaderCell.identifier)
        collectionView.register(VoteCell.self, forCellWithReuseIdentifier: VoteCell.identifier)
        collectionView.register(HistoryCell.self, forCellWithReuseIdentifier: HistoryCell.identifier)
        collectionView.register(ChargeCell.self, forCellWithReuseIdentifier: ChargeCell.identifier)
        collectionView.register(CommunityBannerCell.self, forCellWithReuseIdentifier: CommunityBannerCell.identifier)
        collectionView.register(CommunityCell.self, forCellWithReuseIdentifier: CommunityCell.identifier)
        
        
        self.collectionView = collectionView
        self.dataSource = dataSource
        self.delegate = delegate
        super.init()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
}

extension TestAdapter: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return TestSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = TestSection(rawValue: section) else { return 0 }
        switch section {
        case .header:
            return 1
        case .vote:
            return 10
        case .history:
            return 1
        case .charge:
            return 4
        case .communityBanner:
            return 4
        case .community:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let section = TestSection(rawValue: indexPath.section) else { return .init() }
        guard kind == UICollectionView.elementKindSectionHeader else { return .init() }
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.identifier, for: indexPath) as? HeaderView else { return .init() }
        
        if section == .vote,
           section == .community {
            view.configure(hasMoreButton: true)
        }
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = TestSection(rawValue: indexPath.section) else { return .init() }
        print("section: \(section)")
        switch section {
        case .header:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCell.identifier, for: indexPath) as? HeaderCell else { return .init() }
            cell.backgroundColor = .red.withAlphaComponent(0.8)
            return cell
            
        case .vote:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VoteCell.identifier, for: indexPath) as? VoteCell else { return .init() }
            cell.backgroundColor = .green.withAlphaComponent(0.8)
            return cell
            
        case .history:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCell.identifier, for: indexPath) as? HistoryCell else { return .init() }
            cell.backgroundColor = .red.withAlphaComponent(0.8)
            return cell
            
        case .charge:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChargeCell.identifier, for: indexPath) as? ChargeCell else { return .init() }
            cell.backgroundColor = .red.withAlphaComponent(0.8)
            return cell
            
        case .communityBanner:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommunityBannerCell.identifier, for: indexPath) as? CommunityBannerCell else { return .init() }
            cell.backgroundColor = .red.withAlphaComponent(0.8)
            return cell
            
        case .community:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommunityCell.identifier, for: indexPath) as? CommunityCell else { return .init() }
            cell.backgroundColor = .red.withAlphaComponent(0.8)
            return cell
            
        }
    }
}

extension TestAdapter: UICollectionViewDelegate {
    
}
