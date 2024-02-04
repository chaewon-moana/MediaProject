//
//  MediaCollectionViewCell.swift
//  MediaProject
//
//  Created by cho on 1/31/24.
//

import UIKit
import SnapKit

class MediaCollectionViewCell: UICollectionViewCell {
    
    let posterImage = UIImageView()
    let titleLabel = UILabel()
    let ratedLabel = UILabel()
    let adultLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAddView()
        configureLayout()
        configureAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAddView() {
        contentView.addSubviews([titleLabel, posterImage, ratedLabel, adultLabel])
    }
    
    func configureAttribute() {
        backgroundColor = .black
        
        ratedLabel.backgroundColor = .systemRed
        ratedLabel.textColor = .white
        ratedLabel.textAlignment = .center
        ratedLabel.isHidden = true
                
        adultLabel.text = "19"
        adultLabel.font = .boldSystemFont(ofSize: 12)
        adultLabel.textAlignment = .center
        adultLabel.textColor = .black
        adultLabel.backgroundColor = .white
        adultLabel.clipsToBounds = true
        adultLabel.layer.cornerRadius = 12
        adultLabel.layer.borderColor = UIColor.red.cgColor
        adultLabel.layer.borderWidth = 4
        adultLabel.isHidden = true
        
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(20)
        }
        
        posterImage.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
            make.size.equalTo(100)
        }
        
        ratedLabel.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.top.equalTo(posterImage.snp.top)
            make.leading.equalTo(posterImage.snp.leading)
        }
        
        adultLabel.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.top.equalTo(posterImage.snp.top)
            make.trailing.equalTo(posterImage.snp.trailing)
        }
        
    }
}
