//
//  DramaSearchTableViewCell.swift
//  MediaProject
//
//  Created by cho on 2/5/24.
//

import UIKit
import SnapKit

class DramaSearchTableViewCell: BaseTableViewCell {

    let searchesLabel = UILabel()
    
    override func setAddView() {
        contentView.addSubview(searchesLabel)
    }
    
    override func configureLayout() {
        searchesLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(20)
        }
    }
    
    override func configureAttribute() {
        searchesLabel.textColor = .blue
    }
}
