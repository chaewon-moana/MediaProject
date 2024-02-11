//
//  ProfileViewController.swift
//  MediaProject
//
//  Created by cho on 2/11/24.
//

import UIKit
import SnapKit

final class ProfileViewController: BaseViewController {
//
//    let nameLabel = UILabel()
//    let nameTextField = UITextField()
    
    let tableView = UITableView()
    
    var idx: Int = 0
    var list = ["이름", "사용자이름", "소개", "성별"]
    var textList = ["", "", "", ""]
    let vc = ProfileDetailViewController()
    var text = ""
    //TODO: tableView로 만들기,,,
    
    override func subViewDidLoad() {
        view.backgroundColor = .black
        //nameTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "ProfileTableViewCell")
    }
    
    override func setAddView() {
        //view.addSubviews([nameLabel, nameTextField])
        view.addSubview(tableView)
    }
 
    override func configureLayout() {
//        nameLabel.snp.makeConstraints { make in
//            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
//            make.height.equalTo(24)
//        }
//        
//        nameTextField.snp.makeConstraints { make in
//            make.leading.equalTo(nameLabel.snp.trailing).offset(10)
//            make.width.equalTo(200)
//            make.top.equalTo(view.safeAreaLayoutGuide)
//            make.height.equalTo(24)
//        }
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

    }
    
    override func configureAttribute() {
//        nameLabel.textColor = .white
//        nameLabel.text = "이름"
//        
//        nameTextField.backgroundColor = .blue
    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
        
        cell.tag = indexPath.row
        cell.inputLabel.text = list[indexPath.row]
        cell.inputTextField.text = textList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vc.sendData = { value in
            self.textList[indexPath.row] = value
            tableView.reloadData()
        }
        vc.textLabel.text = list[indexPath.row]
        vc.inputTextField.text = ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}



//extension ProfileViewController: UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        print("글자아")
//        let vc = ProfileDetailViewController()
//        vc.sendData = { value in
//            self.nameTextField.text = value
//        }
//        navigationController?.pushViewController(vc, animated: true)
//    }
//}
