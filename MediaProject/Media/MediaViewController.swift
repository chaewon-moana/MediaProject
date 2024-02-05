//
//  ViewController.swift
//  MediaProject
//
//  Created by cho on 1/30/24.
//

import UIKit
import SnapKit
import Kingfisher

class MediaViewController: BaseViewController {

    let searchBar = UISearchBar()
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.delegate = self
        view.dataSource = self
        view.register(MediaTableViewCell.self, forCellReuseIdentifier: "MediaTableViewCell")
        view.register(DramaSearchTableViewCell.self, forCellReuseIdentifier: "DramaSearchTableViewCell")
        return view
    }()
    
    let tmdbManager = TMDBAPIManager.shared
    let tmdbsesssionManager = TMDBSessionManager.shared
    let categoryList = ["Trend", "TopRated", "Popular"]
    var dramaList: [[Drama]] = [[],[],[]]
    var searchList: [String] = []
    var changedTableCell = 0 {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var searchString = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate  = self
        
        navigationItem.title = "DRAMA"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = .gray
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        TMDBURLSession()
        //TMDBAlamofire()
        searchBar.searchTextField.textColor = .white
        
    }
    
    func TMDBURLSession() {
        let group = DispatchGroup()
 
        group.enter()
        tmdbsesssionManager.fetchDrama(api: .trending) { tv, error in
            if error == nil {
                guard let tv = tv else { return }
                self.dramaList[0] = tv
            }
            group.leave()
        }
        
        group.enter()
        tmdbsesssionManager.fetchDrama(api: .topRated) { tv, error in
            if error == nil {
                guard let tv = tv else { return }
                self.dramaList[1] = tv
            }
            group.leave()
        }
        
        group.enter()
        tmdbsesssionManager.fetchDrama(api: .popluar) { tv, error in
            if error == nil {
                guard let tv = tv else { return }
                self.dramaList[2] = tv
            }
            group.leave()
        }

        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    func TMDBAlamofire() {
        
        let group = DispatchGroup()
 
        group.enter()
        tmdbManager.fetchDrama(api: .topRated) { tv in
            self.dramaList[1] = tv
            group.leave()
        }
        
        group.enter()
        tmdbManager.fetchDrama(api: .popluar) { tv in
            self.dramaList[2] = tv
            group.leave()
        }
        
        group.enter()
        tmdbManager.fetchDrama(api: .trending) { tv in
            self.dramaList[0] = tv
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    override func setAddView() {
        view.addSubviews([searchBar, tableView])
    }
    
    override func configureAttribute() {
        tableView.backgroundColor = .black
        
        searchBar.searchBarStyle = .minimal
    }
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}


extension MediaViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dramaList[0].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCollectionViewCell", for: indexPath) as! MediaCollectionViewCell
        
        let baseURL = "https://image.tmdb.org/t/p/w500"
        
        let item = dramaList[collectionView.tag][indexPath.item]
        let url = URL(string: baseURL + (item.poster ?? ""))
        cell.posterImage.kf.setImage(with: url)
        cell.adultLabel.isHidden = item.adult ? false : true
        if collectionView.tag == 1 {
            cell.ratedLabel.isHidden = false
            cell.ratedLabel.text = "\(indexPath.item+1)"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DramaViewController()
        
        let item = dramaList[collectionView.tag][indexPath.item]
        vc.index = item.id
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension MediaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return changedTableCell == 0 ? 3 : searchList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        if changedTableCell == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MediaTableViewCell", for: indexPath) as! MediaTableViewCell
            
            cell.categoryLabel.text = categoryList[indexPath.row]
            
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.collectionView.register(MediaCollectionViewCell.self, forCellWithReuseIdentifier: "MediaCollectionViewCell")
            cell.collectionView.tag = indexPath.item
            cell.collectionView.reloadData()

            return cell
        } else {
            let searchCell = tableView.dequeueReusableCell(withIdentifier: "DramaSearchTableViewCell", for: indexPath) as! DramaSearchTableViewCell
            
            searchCell.backgroundColor = .black
            searchCell.searchesLabel.text = searchList[indexPath.row]
            searchCell.searchesLabel.textColor = .white
            
            return searchCell
        }
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return changedTableCell == 0 ? 200 : 40
    }

}

extension MediaViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        changedTableCell = 1
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        changedTableCell = 0
        
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        guard let text = searchBar.text else { return true }
        
        if text.isEmpty {
            changedTableCell = 0
            return true
        } else {
            return false
        }
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchString = searchBar.text!
        TMDBAPIManager.shared.fetchDrama(api: .search(query: searchString)) { drama in
            self.searchList.removeAll()
            for name in drama {
                print(name.name)
                self.searchList.append(name.name)
            }
            self.tableView.reloadData()
            print("=================")
        }
        
        print(searchString)
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            view.endEditing(true)
            changedTableCell = 0
        }
        
    }
}
