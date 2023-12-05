//
//  ThirdViewController.swift
//  CompositionLayoutMock
//
//  Created by JunHyeok Lee on 12/5/23.
//

import UIKit

/*
 DecorationView,
 Badge
 */

class ThirdViewController: UIViewController {
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
        return collectionView
    }()
    
    private let dataSource: [MySection] = [
        .first((1...30).map(String.init).map(MySection.FirstItem.init(value: ))),
        .second((31...60).map(String.init).map(MySection.SecondItem.init(value: )))
    ]
    
    // MARK: - Life Cycle
    
    static func create() -> ThirdViewController {
        let viewController = ThirdViewController()
        viewController.navigationController?.isNavigationBarHidden = true
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupCollectionViewLayoutConstraints()
        
        self.collectionView.dataSource = self
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
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(groupFractionalHeightFraction)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                // Section
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
                return section
            }
        }
    }
}

extension ThirdViewController: UICollectionViewDataSource {
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

// MARK: - Layout
extension ThirdViewController {
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
