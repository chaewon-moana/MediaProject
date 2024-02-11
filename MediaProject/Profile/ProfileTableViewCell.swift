//
//  ProfileTableViewCell.swift
//  MediaProject
//
//  Created by cho on 2/11/24.
//

import UIKit
import SnapKit

class ProfileTableViewCell: BaseTableViewCell {
    
    let inputLabel = UILabel()
    let inputTextField = UITextField()

    override func setAddView() {
        contentView.addSubviews([inputLabel, inputTextField])
    }
    
    override func configureAttribute() {
        inputLabel.textColor = .gray
        
    }
    
    override func configureLayout() {
        inputLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(80)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(12)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        inputTextField.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.leading.equalTo(inputLabel.snp.trailing)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
