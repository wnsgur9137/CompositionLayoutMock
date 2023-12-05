//
//  BadgeView.swift
//  CompositionLayoutMock
//
//  Created by JunHyeok Lee on 12/5/23.
//

import UIKit

final class BadgeView: UICollectionReusableView {
    
    static let reuseIdentifier = String(describing: BadgeView.self)
    
    private let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        
        addSubviews()
        setupButtonLayoutConstraints()
        
        setupButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtonAction() {
        button.addAction(UIAction(handler: { _ in
            print("Close")
        }), for: .touchUpInside)
    }
}

extension BadgeView {
    private func addSubviews() {
        self.addSubview(button)
    }
    
    private func setupButtonLayoutConstraints() {
        button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
    }
}
