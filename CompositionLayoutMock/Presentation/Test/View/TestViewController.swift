//
//  TestViewController.swift
//  CompositionLayoutMock
//
//  Created by JunHyeok Lee on 12/15/23.
//

import UIKit

private protocol ReusableProtocol: AnyObject {
    static var identifier: String { get }
}

extension UIView: ReusableProtocol {
    public static var identifier: String {
        return String(describing: self)
    }
}

final class TestViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: getCollectionViewCompositionalLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let viewModel: TestViewModel
    private var adapter: TestAdapter?
    
    static func create(with viewModel: TestViewModel) -> TestViewController {
        let viewController = TestViewController(with: viewModel)
        return viewController
    }
    
    init(with viewModel: TestViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.adapter = TestAdapter(
            collectionView: collectionView,
            dataSource: viewModel,
            delegate: self
        )
        
        addSubviews()
        setupLayoutConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func getCollectionViewCompositionalLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            guard let section = TestSection(rawValue: section) else { return nil }
            
            switch section {
            case .header: return self.makeHeaderSection()
            case .vote: return self.makeVoteSection()
            case .history: return self.makeHistorySection()
            case .charge: return self.makeChargeSection()
            case .communityBanner: return self.makeCommunityBannerSection()
            case .community: return self.makeCommunitySection()
            }
        }
    }
}

extension TestViewController: TestDelegate {
    
}

// MARK: - Layout

extension TestViewController {
    
    private func makeHeaderBoundaryItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(60.0)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
    }
    
    private func makeHeaderSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(60.0)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
        return section
    }
    
    private func makeVoteSection() -> NSCollectionLayoutSection {
        let headerSupplimentary = self.makeHeaderBoundaryItem()
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(240.0),
            heightDimension: .estimated(316.0)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.boundarySupplementaryItems = [headerSupplimentary]
        section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
        return section
    }
    
    private func makeHistorySection() -> NSCollectionLayoutSection {
        let headerSupplimentary = self.makeHeaderBoundaryItem()
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(80.0)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        group.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 20.0
        section.boundarySupplementaryItems = [headerSupplimentary]
        section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
        return section
    }
    
    private func makeChargeSection() -> NSCollectionLayoutSection {
        let headerSupplimentary = self.makeHeaderBoundaryItem()
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0 / 4.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(120.0)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        group.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [headerSupplimentary]
        section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
        return section
    }
    
    private func makeCommunityBannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(80)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        section.contentInsets = .init(top: 0, leading: 0, bottom: 20, trailing: 0)
        return section
    }
    
    private func makeCommunitySection() -> NSCollectionLayoutSection {
        let headerSupplimentary = self.makeHeaderBoundaryItem()
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [headerSupplimentary]
        section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        return section
    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
