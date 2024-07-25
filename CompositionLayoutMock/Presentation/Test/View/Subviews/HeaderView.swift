//
//  HeaderView.swift
//  CompositionLayoutMock
//
//  Created by JunHyeok Lee on 7/25/24.
//

import UIKit

final class HeaderView: UICollectionReusableView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Header"
        label.textColor = .label
        return label
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("더보기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    func configure(hasMoreButton: Bool) {
        guard hasMoreButton else { return }
        setupMoreButtonLayout()
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 12.0),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setupMoreButtonLayout() {
        addSubview(moreButton)
        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: topAnchor),
            moreButton.rightAnchor.constraint(equalTo: rightAnchor),
            moreButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            moreButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
}
