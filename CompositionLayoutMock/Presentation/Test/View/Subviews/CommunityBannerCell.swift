//
//  CommunityBannerCell.swift
//  CompositionLayoutMock
//
//  Created by JunHyeok Lee on 7/25/24.
//

import UIKit

final class CommunityBannerCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.text = "1/4"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(imageView)
        imageView.addSubview(countLabel)
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            countLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -12.0),
            countLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -12.0)
        ])
    }
}
