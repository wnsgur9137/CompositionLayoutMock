//
//  HeaderFooterView.swift
//  CompositionLayoutMock
//
//  Created by JunHyeok Lee on 12/5/23.
//

import UIKit

final class HeaderFooterView: UICollectionReusableView {
    static let reuseIdentifier = String(describing: HeaderFooterView.self)
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .gray
        self.addSubview(label)
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(text: nil)
    }
    
    func prepare(text: String?) {
        self.label.text = text
    }
}
