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
    var list: Detail = Detail(id: 0, name: "", poster: "", backdrop: "", rating: 0.0, overview: "")
    var creditList: DramaCredits = DramaCredits(cast: [])
    var recommandationList: [Recommandation] = []
    
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let group = DispatchGroup()
        
        view.backgroundColor = .black
        
        dramaInfoTableView.delegate = self
        dramaInfoTableView.dataSource = self
        
        //dramaInfoTableView.rowHeight = UITableView.automaticDimension
        
        group.enter()
        tmdbManager.fetchDetailModel(id: list.id) { model in
            self.list = model
            group.leave()
        }
        
        group.enter()
        tmdbManager.fetchCreditsModel(id: list.id) { credits in
            self.creditList = credits
            group.leave()
        }
        
        group.enter()
        tmdbManager.fetchRecommandationModel(id: list.id) { recommandation in
            self.recommandationList = recommandation.results
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.dramaInfoTableView.reloadData()
        }
        
        dramaInfoTableView.register(CreditsTableViewCell.self, forCellReuseIdentifier: "CreditsTableViewCell")
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
        titleLabel.text = list.name
        titleLabel.textColor = .white
    }
}

extension DramaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let Infocell = tableView.dequeueReusableCell(withIdentifier: "DramaInfoTableViewCell", for: indexPath) as! DramaInfoTableViewCell
            
            let baseURL = "https://image.tmdb.org/t/p/w500"
            let url = URL(string:baseURL + (list.poster ?? ""))
            Infocell.posterImage.kf.setImage(with: url)
            Infocell.nameLabel.text = "제목 : \(list.name)"
            Infocell.backImageView.kf.setImage(with: URL(string: baseURL + (list.backdrop ?? "")))
            Infocell.ratingLabel.text = "평점 : \(list.rating)"
            Infocell.overviewLabel.text = list.overview
            return Infocell
            
        } else {
            let creditCell = tableView.dequeueReusableCell(withIdentifier: "CreditsTableViewCell", for: indexPath) as! CreditsTableViewCell
            
            creditCell.collectionView.delegate = self
            creditCell.collectionView.dataSource = self
            
            creditCell.collectionView.register(DramaCreditsCollectionViewCell.self, forCellWithReuseIdentifier: "DramaCreditsCollectionViewCell")
            creditCell.collectionView.reloadData()
            creditCell.collectionView.tag = indexPath.item

            return creditCell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 500
        } else {
            return 180
        }
    }
    
}

extension DramaViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return creditList.cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let creditsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DramaCreditsCollectionViewCell", for: indexPath) as! DramaCreditsCollectionViewCell
        let baseURL = "https://image.tmdb.org/t/p/w500"
        
        if collectionView.tag == 1 {
            let url = URL(string: baseURL + (creditList.cast[indexPath.item].profile_path ?? ""))
            creditsCell.image.kf.setImage(with: url)
            creditsCell.name.text = creditList.cast[indexPath.item].name
            
            
        } else {
            let url = URL(string: baseURL + (recommandationList[indexPath.item].poster_path ?? ""))
            creditsCell.image.kf.setImage(with: url)
            creditsCell.name.text = recommandationList[indexPath.item].name
            
        }
        return creditsCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("픽미픽미업")
    }
}
