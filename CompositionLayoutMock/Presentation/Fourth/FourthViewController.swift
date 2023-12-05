//
//  FourthViewController.swift
//  CompositionLayoutMock
//
//  Created by JunHyeok Lee on 12/5/23.
//

/*
 // Standard scroll view behavior: UIScrollViewDecelerationRateNormal
 case continuous

 // Scrolling will come to rest on the leading edge of a group boundary
 case continuousGroupLeadingBoundary

 // Standard scroll view paging behavior (UIScrollViewDecelerationRateFast) with page size == extent of the collection view's bounds
 case paging

 // Fractional size paging behavior determined by the sections layout group's dimension
 case groupPaging

 // Same of group paging with additional leading and trailing content insets to center each group's contents along the orthogonal axis
 case groupPagingCentered
 */

import UIKit

final class FourthViewController: UIViewController {
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
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: getLayout())
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
    
    static func create() -> FourthViewController {
        let viewController = FourthViewController()
        viewController.navigationController?.isNavigationBarHidden = true
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupCollectionViewLayoutConstraints()
        
        self.collectionView.dataSource = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.collectionView.performBatchUpdates(nil, completion: nil)
    }
    
    private func getLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, env -> NSCollectionLayoutSection? in
            switch self.dataSource[sectionIndex] {
            case .first:
                return self.getMainSection()
            case .second:
                return self.getSubSection()
            }
        }
    }
    
    private func getMainSection() -> NSCollectionLayoutSection {
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
    }
    
    private func getSubSection() -> NSCollectionLayoutSection {
        let itemCount = 4
        let itemFractionalWidthFraction = 1.0 / Double(itemCount) // horizontal 5개의 셀
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
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            repeatingSubitem: item,
            count: itemCount
        )
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets(top: itemInset, leading: itemInset, bottom: itemInset, trailing: itemInset)
        section.orthogonalScrollingBehavior = .paging
        section.visibleItemsInvalidationHandler = { [weak self] (visibleItems, offset, env) in
            guard let self = self else { return }
            let normalizedOffsetX = offset.x
            let centerPoint = CGPoint(x: normalizedOffsetX + self.collectionView.bounds.width / 2, y: 20)
            visibleItems.forEach { item in
                guard let cell = self.collectionView.cellForItem(at: item.indexPath) else { return }
                UIView.animate(withDuration: 0.3) {
                    cell.transform = item.frame.contains(centerPoint) ? .identity : CGAffineTransform(scaleX: 0.9, y: 0.9)
                }
            }
        }
        return section
    }
}

extension FourthViewController: UICollectionViewDataSource {
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
extension FourthViewController {
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
