//
//  textLabel.swift
//  MediaProject
//
//  Created by cho on 2/11/24.
//

import UIKit

class ProfileLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    func configureView() {
        textColor = .gray
        font = .systemFont(ofSize: 14)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
