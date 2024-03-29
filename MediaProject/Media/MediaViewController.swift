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

    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.delegate = self
        view.dataSource = self
        view.register(MediaTableViewCell.self, forCellReuseIdentifier: "MediaTableViewCell")
        return view
    }()
    
    let tmdbManager = TMDBAPIManager.shared
    let tmdbsesssionManager = TMDBSessionManager.shared
    let categoryList = ["Trend", "TopRated", "Popular"]
    var dramaList: [[Drama]] = [[],[],[]]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "DRAMA"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = .gray
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        
        TMDBURLSession()
        //TMDBAlamofire()
        
    }
    
    @objc func searchButtonTapped() {
        let vc = DramaSearchViewController()
            
        navigationController?.pushViewController(vc, animated: true)
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
        view.addSubviews([tableView])
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
