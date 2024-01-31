//
//  BaseTableViewCell.swift
//  MediaProject
//
//  Created by cho on 1/31/24.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
