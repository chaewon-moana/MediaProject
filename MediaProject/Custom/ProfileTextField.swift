//
//  ProfileTextField.swift
//  MediaProject
//
//  Created by cho on 2/11/24.
//

import UIKit

class ProfileTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    func configureView() {
        placeholder = "텍스트입니다아"
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
