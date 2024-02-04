//
//  DramaCastingCollectionViewCell.swift
//  MediaProject
//
//  Created by cho on 2/2/24.
//

import UIKit
import SnapKit

class DramaCreditsCollectionViewCell: BaseCollectionViewCell {
    
    var image = UIImageView()
    var name = UILabel()
    
    override func setAddView() {
        contentView.addSubview(image)
        contentView.addSubview(name)
        contentView.isUserInteractionEnabled = true
    }
    
    override func configureAttribute() {
        contentView.backgroundColor = .gray
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.borderWidth = 1
        
        image.image = UIImage(systemName: "star")
        image.contentMode = .scaleToFill
        name.textAlignment = .center
        name.textColor = .white
        name.text = "테에스트으"
        name.font = .systemFont(ofSize: 12)
        name.numberOfLines = 2
    }
    
    override func configureLayout() {
        image.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(100)
            
        }
        name.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(20)
        }
        
    }
    
}
