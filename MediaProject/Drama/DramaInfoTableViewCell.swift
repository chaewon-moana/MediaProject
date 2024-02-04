//
//  DramaInfoTableViewCell.swift
//  MediaProject
//
//  Created by cho on 1/31/24.
//

import UIKit
import SnapKit

class DramaInfoTableViewCell: BaseTableViewCell {
    
    let backImageView = UIImageView()
    let posterImage = UIImageView()
    let nameLabel = UILabel()
    //let enNameLabel = UILabel()
    let airDateLabel = DramaInfoLabel()
    let genreLabel = DramaInfoLabel()
    let ratingLabel = DramaInfoLabel()
    let overviewLabel = UILabel()
    let underLineView = UIView()
    
    let lastEpisode = UILabel() //가장 최근화로 이동하는,,,
    let nextEpisode = UILabel() //다음화로 이동
  
    let tmdbManager = TMDBAPIManager.shared
    
    let gradientLayer = CAGradientLayer()
    
    override func setAddView() {
        contentView.addSubviews([backImageView, overviewLabel, underLineView, posterImage, nameLabel, ratingLabel, genreLabel, airDateLabel])
        contentView.backgroundColor = .black
    }
    
    override func configureLayout() {
        
        backImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(350)
        }
        
        posterImage.snp.makeConstraints { make in
            make.bottom.equalTo(backImageView.snp.bottom).inset(30)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(10)
            make.width.equalTo(120)
            make.height.equalTo(160)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImage.snp.trailing).offset(12)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(12)
            make.bottom.equalTo(airDateLabel.snp.top).inset(8)
            make.height.equalTo(36)
        }
        
  
        airDateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(genreLabel.snp.top).inset(8)
            make.leading.equalTo(posterImage.snp.trailing).offset(12)
            make.height.equalTo(20)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.bottom.equalTo(ratingLabel.snp.top).inset(8)
            make.leading.equalTo(posterImage.snp.trailing).offset(12)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            make.height.greaterThanOrEqualTo(20)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.bottom.equalTo(backImageView.snp.bottom).inset(40)
            make.leading.equalTo(posterImage.snp.trailing).offset(12)
            make.height.equalTo(20)
        }
        
        underLineView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(1)
            make.top.equalTo(backImageView.snp.bottom).inset(2)
        }
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(underLineView.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(8)
        }
    }

    override func configureAttribute() {

        posterImage.clipsToBounds = true
        posterImage.layer.cornerRadius = 8
        
        nameLabel.textColor = .white
        nameLabel.font = .systemFont(ofSize: 15)
        nameLabel.numberOfLines = 2
        
        backImageView.alpha = 0.2
        
        genreLabel.numberOfLines = 0
        underLineView.layer.borderColor = UIColor.gray.cgColor
        underLineView.layer.borderWidth = 1
        
        overviewLabel.numberOfLines = 0
        overviewLabel.textColor = .white
        overviewLabel.font = .systemFont(ofSize: 13)

    }
}

