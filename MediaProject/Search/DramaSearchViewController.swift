//
//  DramaSeachViewController.swift
//  MediaProject
//
//  Created by cho on 2/6/24.
//

import UIKit
import SnapKit

class DramaSearchViewController: BaseViewController {

    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    let tmdbAPIMamager = TMDBAPIManager.shared
    var searchList: [String] = []
    
    override func setAddView() {
        view.addSubviews([searchBar, tableView])
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(4)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureAttribute() {
        tableView.register(DramaSearchTableViewCell.self, forCellReuseIdentifier: "DramaSearchTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }
}

extension DramaSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DramaSearchTableViewCell", for: indexPath) as! DramaSearchTableViewCell
        
        cell.searchesLabel.text = searchList[indexPath.row]
        cell.searchesLabel.textColor = .black
        return cell
    }
}

extension DramaSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else { return }
        searchList.removeAll()
        tmdbAPIMamager.fetchDrama(api: .search(query: text)) { drama in
            for idx in drama {
                self.searchList.append(idx.name)
            }
        }
        tableView.reloadData()
    }
}
