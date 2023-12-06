//
//  SecondViewController.swift
//  CompositionLayoutMock
//
//  Created by JunHyeok Lee on 12/4/23.
//

/*
 HeaderView,
 FooterView,
 SideView (Left, Right)
 */

import UIKit

final class SupplementaryViewController: UIViewController {
    
    enum MySection {
        case first([FirstItem])
        case second([SecondItem])
        
        struct FirstItem {
            let value: String
        }
        struct SecondItem {
            let value: String
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: Self.getCollectionViewCompositionalLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: -2, left: 0, bottom: 0, right: 4)
        collectionView.contentInset = .zero
        collectionView.clipsToBounds = true
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        collectionView.register(HeaderFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        collectionView.register(HeaderFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FooterView")
        collectionView.register(HeaderFooterView.self, forSupplementaryViewOfKind: "LeftView", withReuseIdentifier: "LeftView")
        collectionView.register(HeaderFooterView.self, forSupplementaryViewOfKind: "RightView", withReuseIdentifier: "RightView")
        return collectionView
    }()
    
    private let dataSource: [MySection] = [
        .first((1...30).map(String.init).map(MySection.FirstItem.init(value: ))),
        .second((31...60).map(String.init).map(MySection.SecondItem.init(value: )))
    ]
    
    // MARK: - Life Cycle
    
    static func create() -> SupplementaryViewController {
        let viewController = SupplementaryViewController()
        viewController.navigationController?.isNavigationBarHidden = true
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setupCollectionViewLayoutConstraints()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    static func getCollectionViewCompositionalLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            switch section {
            case 0:
                let itemFractionalWidthFraction = 1.0 / 3.0 // horizontal 3개의 셀
                let groupFractionalHeightFraction = 1.0 / 4.0 // vertical 4개의 셀
                let itemInset: CGFloat = 2.5
                
                // Item
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(itemFractionalWidthFraction),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
                
                // Group
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(groupFractionalHeightFraction)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
                
                // Header
                let headerFooterSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(100.0)
                )
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerFooterSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                
                // footer
                let footer = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerFooterSize,
                    elementKind: UICollectionView.elementKindSectionFooter,
                    alignment: .bottom
                )
                section.boundarySupplementaryItems = [header, footer]
                
                // Footer
                return section
                
            default:
                let itemFractionalWidthFraction = 1.0 / 5.0 // horizontal 5개의 셀
                let groupFractionalHeightFraction = 1.0 / 4.0 // vertical 4개의 셀
                let itemInset: CGFloat = 2.5
                
                // Item
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(itemFractionalWidthFraction),
                    heightDimension: .fractionalHeight(1)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
                
                // Group
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.8),
                    heightDimension: .fractionalHeight(groupFractionalHeightFraction)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.edgeSpacing = NSCollectionLayoutEdgeSpacing(
                    leading: .flexible(0),
                    top: nil,
                    trailing: .flexible(0),
                    bottom: nil
                )
                
                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
                
                // Left View
                let leftRightSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.1),
                    heightDimension: .fractionalHeight(1.0)
                )
                let leftView = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: leftRightSize,
                    elementKind: "LeftView",
                    alignment: .leading
                )
                
                // Right View
                let rightView = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: leftRightSize,
                    elementKind: "RightView",
                    alignment: .trailing
                )
                section.boundarySupplementaryItems = [leftView, rightView]
                
                return section
            }
        }
    }
}

// MARK: - CollectionView DataSource
extension SupplementaryViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.dataSource[section] {
        case let .first(items):
            return items.count
        case let .second(items):
            return items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as? CollectionViewCell else { return .init() }
        switch self.dataSource[indexPath.section] {
        case let .first(items):
            cell.prepare(text: items[indexPath.item].value)
        case let .second(items):
            cell.prepare(text: items[indexPath.item].value)
        }
        return cell
    }
}

// MARK: - CollectionView Delegate
extension SupplementaryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as? HeaderFooterView else { return .init() }
            headerView.prepare(text: "Header")
            return headerView
            
        case UICollectionView.elementKindSectionFooter:
            guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FooterView", for: indexPath) as? HeaderFooterView else { return .init() }
            footerView.prepare(text: "Footer")
            return footerView
            
        case "LeftView":
            guard let leftView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LeftView", for: indexPath) as? HeaderFooterView else { return .init() }
            leftView.prepare(text: "LeftView")
            return leftView
            
        case "RightView":
            guard let rightView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "RightView", for: indexPath) as? HeaderFooterView else { return .init() }
            rightView.prepare(text: "RightView")
            return rightView
            
        default:
            return .init()
        }
    }
}

// MARK: - Layout
extension SupplementaryViewController {
    private func addSubviews() {
        self.view.addSubview(collectionView)
    }
    
    private func setupCollectionViewLayoutConstraints() {
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}
