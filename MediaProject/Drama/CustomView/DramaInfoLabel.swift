//
//  DramaInfoLabel.swift
//  MediaProject
//
//  Created by cho on 2/3/24.
//

import UIKit

class DramaInfoLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAttribute()
    }
    
    func configureAttribute() {
        textColor = .white
        font = .systemFont(ofSize: 13)
        
        
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
