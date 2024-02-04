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
    let overviewLabel = UILabel()
    let lastEpisode = UILabel() //가장 최근화로 이동하는,,,
    let nextEpisode = UILabel() //다음화로 이동
    let ratingLabel = UILabel()
        
    let tmdbManager = TMDBAPIManager.shared
    
    let gradientLayer = CAGradientLayer()
    
    override func setAddView() {
        contentView.addSubviews([backImageView, posterImage, nameLabel, ratingLabel, overviewLabel])
        contentView.backgroundColor = .black
    }
    
    override func configureLayout() {
        
        backImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        posterImage.snp.makeConstraints { make in
            make.leading.top.equalTo(contentView.safeAreaLayoutGuide)
            make.width.equalTo(120)
            make.height.equalTo(160)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImage.snp.trailing).offset(12)
            make.top.equalTo(contentView.snp.top).offset(12)
            make.height.equalTo(24)
        }
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(posterImage.snp.trailing).offset(12)
            make.height.equalTo(24)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(8)
        }
    }

    override func configureAttribute() {
        nameLabel.textColor = .white
        backImageView.alpha = 0.2
        
        ratingLabel.textColor = .white
        overviewLabel.numberOfLines = 0
        overviewLabel.textColor = .white
        overviewLabel.font = .systemFont(ofSize: 13)
        
        //backImageView.addGradient(frame: .init(x: 0, y: 0, width: 100, height: 100))
        gradientLayer.frame = backImageView.bounds
        
        let colors: [CGColor] = [
            UIColor.red.cgColor,
            UIColor.white.cgColor
        ]
        gradientLayer.colors = colors

    }
}

