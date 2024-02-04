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
        return view
    }()
    
    let tmdbManager = TMDBAPIManager.shared
    let categoryList = ["Trend", "TopRated", "Popular"]
    var posterList: [TrendTV] = []
    var topRatedList: [TopTV] = []
    var popularList: [PopularTV] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let group = DispatchGroup()
        
        group.enter()
        tmdbManager.fetchTrendTV { tv in
            self.posterList = tv
            group.leave()
        }
        
        group.enter()
        tmdbManager.fetchTopRatedTV { tv in
            self.topRatedList = tv
            group.leave()
        }
        
        group.enter()
        tmdbManager.fetchPopularTV { tv in
            self.popularList = tv
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
            //print(self.topRatedList)
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
        return posterList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCollectionViewCell", for: indexPath) as! MediaCollectionViewCell
        
        let baseURL = "https://image.tmdb.org/t/p/w500"
        if collectionView.tag == 0 {
            let item = posterList[indexPath.item]
            let url = URL(string: baseURL + item.poster)
            cell.posterImage.kf.setImage(with: url)
            cell.adultLabel.isHidden = item.adult ? false : true
        } else if collectionView.tag == 1 {
            let item = topRatedList[indexPath.item]
            let url = URL(string: baseURL + item.poster)
            cell.posterImage.kf.setImage(with: url)
            cell.adultLabel.isHidden = item.adult ? false : true

            cell.ratedLabel.isHidden = false
            cell.ratedLabel.text = String(indexPath.item + 1)
            
        } else {
            let item = popularList[indexPath.item]
            let url = URL(string: baseURL + (item.poster_path ?? ""))
            cell.posterImage.kf.setImage(with: url)
            cell.adultLabel.isHidden = item.adult ? false : true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DramaViewController()
        if collectionView.tag == 0 {
            let item = posterList[indexPath.item]
            vc.index = item.id
        } else if collectionView.tag == 1 {
            let item = topRatedList[indexPath.item]
            vc.index = item.id
        } else {
            let item = popularList[indexPath.item]
            vc.index = item.id
        }
    
        navigationController?.pushViewController(vc, animated: true)
        
    }
    


}


extension MediaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MediaTableViewCell", for: indexPath) as! MediaTableViewCell
        cell.categoryLabel.text = categoryList[indexPath.row]
        
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        cell.collectionView.register(MediaCollectionViewCell.self, forCellWithReuseIdentifier: "MediaCollectionViewCell")
        cell.collectionView.tag = indexPath.item
        cell.collectionView.reloadData()

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

}
