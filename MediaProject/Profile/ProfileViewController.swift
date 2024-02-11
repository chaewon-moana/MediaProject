//
//  ProfileViewController.swift
//  MediaProject
//
//  Created by cho on 2/11/24.
//

import UIKit
import SnapKit

final class ProfileViewController: BaseViewController {

    let nameLabel = UILabel()
    let nameTextField = UITextField()
    let userNameLabel = UILabel()
    let userNameTextField = UITextField()
    let sexLabel = UILabel()
    let sexTextField = UITextField()
    let descriptionLabel = UILabel()
    let descriptionTextField = UITextField()
    let linkLabel = UILabel()
    let linkTextField = UITextField()
    //let professionalLabel = UILabel()
    //TODO: tableView로 만들기,,,
    
    override func subViewDidLoad() {
        view.backgroundColor = .black
        nameTextField.delegate = self
    }
    
    override func setAddView() {
        view.addSubviews([nameLabel, nameTextField])
    }
 
    override func configureLayout() {
        nameLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.height.equalTo(24)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.trailing).offset(10)
            make.width.equalTo(200)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(24)
        }

    }
    
    override func configureAttribute() {
        nameLabel.textColor = .white
        nameLabel.text = "이름"
        
        nameTextField.backgroundColor = .blue
    }

}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("글자아")
        let vc = ProfileDetailViewController()
        vc.sendData = { value in
            self.nameTextField.text = value
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
