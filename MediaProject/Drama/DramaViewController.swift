//
//  DramaViewController.swift
//  MediaProject
//
//  Created by cho on 1/31/24.
//

import UIKit
import SnapKit
import Kingfisher
//37854 -> 원피스
class DramaViewController: BaseViewController{

    let dramaInfoTableView = UITableView()
    let titleLabel = UILabel()
    
    let tmdbManager = TMDBAPIManager.shared
    var list: Detail = Detail(id: 0, name: "", poster: "")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let group = DispatchGroup()
        
        dramaInfoTableView.delegate = self
        dramaInfoTableView.dataSource = self
        
        dramaInfoTableView.rowHeight = dramaInfoTableView.estimatedRowHeight
        group.enter()
        tmdbManager.fetchDetailModel { model in
            print(model)
            self.list = model
            self.dramaInfoTableView.reloadData()
            group.leave()
        }
        
        dramaInfoTableView.register(DramaInfoTableViewCell.self, forCellReuseIdentifier: "DramaInfoTableViewCell")
    }
    
    override func setAddView() {
        view.addSubviews([dramaInfoTableView, titleLabel])
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(24)
        }
        
        dramaInfoTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    override func configureAttribute() {
        titleLabel.text = list.poster
        titleLabel.textColor = .red
    }

}


extension DramaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DramaInfoTableViewCell", for: indexPath) as! DramaInfoTableViewCell
        
        if indexPath.row == 0 {
            let baseURL = "https://image.tmdb.org/t/p/w500"
            let url = URL(string:baseURL + (list.poster ?? ""))
            cell.posterImage.kf.setImage(with: url)
            cell.nameLabel.text = list.name
        }
        
        return cell
    }
    
    
}
