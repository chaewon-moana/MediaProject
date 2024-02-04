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

    let tmdbManager = TMDBAPIManager.shared
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.delegate = self
        view.dataSource = self
        view.register(MediaTableViewCell.self, forCellReuseIdentifier: "MediaTableViewCell")
        return view
    }()
    
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
        view.addSubview(tableView)
    }
    
    override func configureAttribute() {
        tableView.backgroundColor = .black
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
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
            let url = URL(string: baseURL + (item.poster_path ?? "/qPmVoG8G9tc1nN8ZwGV2zYcknit.jpg")) 
            cell.posterImage.kf.setImage(with: url)
            cell.adultLabel.isHidden = item.adult ? false : true
        }
        //collectionView.reloadData()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DramaViewController()
        let item = posterList[indexPath.item]
        
        vc.list = Detail(id: item.id, name: item.name, poster: item.poster, backdrop: item.backdrop, rating: 5.0, overview: item.overview)
        
        navigationController?.pushViewController(vc, animated: true)
        
        print(posterList[indexPath.item].name)
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
