//
//  MediaCollectionViewCell.swift
//  MediaProject
//
//  Created by cho on 1/31/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAddView()
        configureAttribute()
        configureLayout()
    }

    func setAddView() {
        
    }
    
    func configureAttribute() {
        
    }
    
    func configureLayout() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
