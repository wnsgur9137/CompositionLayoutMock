//
//  HistoryCell.swift
//  CompositionLayoutMock
//
//  Created by JunHyeok Lee on 7/25/24.
//

import UIKit

final class HistoryCell: UICollectionViewCell {
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("더 보기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        layer.cornerRadius = 12.0
        addSubviews()
        setupLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(label)
        addSubview(button)
    }
    
    private func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 12.0),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            button.rightAnchor.constraint(equalTo: rightAnchor, constant: -12.0),
            button.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 120.0)
        ])
    }
}
