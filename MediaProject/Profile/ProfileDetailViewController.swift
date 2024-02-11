//
//  ProfileDetailViewController.swift
//  MediaProject
//
//  Created by cho on 2/11/24.
//

import UIKit
import SnapKit

class ProfileDetailViewController: BaseViewController {

    let textLabel = UILabel()
    let inputTextField = UITextField()
    let button = UIButton()
    
    var sendData: ((String) -> Void)?
    
    override func subViewDidLoad() {
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    
    @objc func buttonTapped() {
        sendData?(inputTextField.text!)
        navigationController?.popViewController(animated: true)

    }
    override func setAddView() {
        view.addSubviews([textLabel, inputTextField, button])
    }
    
    override func configureLayout() {
        textLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.height.equalTo(20)
        }
        
        inputTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(textLabel.snp.trailing).offset(20)
            make.height.equalTo(30)
        }
        
        button.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
            make.centerY.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureAttribute() {
        textLabel.textColor = .gray
        textLabel.text = "이름"
        
        inputTextField.placeholder = "이름을 입력해주세요"
        inputTextField.backgroundColor = .white
        
        button.backgroundColor = .blue
        button.setTitle("확인", for: .normal)
        
    }
    

    
}
