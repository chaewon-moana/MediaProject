//
//  DramaInfoTableViewCell.swift
//  MediaProject
//
//  Created by cho on 1/31/24.
//

import UIKit
import SnapKit

class DramaInfoTableViewCell: BaseTableViewCell {
    
    let posterImage = UIImageView()
    let nameLabel = UILabel()
    let overviewLabel = UILabel()
    let lastEpisode = UILabel() //가장 최근화로 이동하는,,,
    let nextEpisode = UILabel() //다음화로 이동
    
    let tmdbManager = TMDBAPIManager.shared
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    }
    
    override func setAddView() {
        contentView.addSubviews([posterImage, nameLabel])
        contentView.backgroundColor = .red
    }
    
    override func configureLayout() {
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
    }

    override func configureAttribute() {
        nameLabel.text = "테스트테스트테스트"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

