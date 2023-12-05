//
//  DecorationView.swift
//  CompositionLayoutMock
//
//  Created by JunHyeok Lee on 12/5/23.
//

import UIKit

final class DecorationView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white.withAlphaComponent(1)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 12.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
