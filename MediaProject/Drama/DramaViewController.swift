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

    let tmdbManager = TMDBAPIManager.shared
    var list: Detail = Detail(id: 0, name: "", poster: "", backdrop: "", rating: 0.0, overview: "", runtime: [], firstAirDate: "", genres: [])
    var creditList: DramaCredits = DramaCredits(cast: [])
    var recommandationList: [Recommandation] = []
    
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let group = DispatchGroup()
        
        view.backgroundColor = .black
        
        dramaInfoTableView.delegate = self
        dramaInfoTableView.dataSource = self
        
        
        group.enter()
        tmdbManager.fetchDetailModel(id: index) { model in
            self.list = model
            group.leave()
        }
        
        group.enter()
        tmdbManager.fetchCreditsModel(id: index) { credits in
            self.creditList = credits
            group.leave()
        }
        
        group.enter()
        tmdbManager.fetchRecommandationModel(id: index) { recommandation in
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
        view.addSubview(dramaInfoTableView)
    }
    
    override func configureLayout() {
        dramaInfoTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    override func configureAttribute() {

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
            Infocell.airDateLabel.text = list.firstAirDate
            
            var tmp = "장르 : "
            for genre in list.genres {
                tmp += "\(genre.name) | "
            }
            
            Infocell.genreLabel.text = tmp
            return Infocell
            
        } else {
            let creditCell = tableView.dequeueReusableCell(withIdentifier: "CreditsTableViewCell", for: indexPath) as! CreditsTableViewCell
            
            creditCell.collectionView.delegate = self
            creditCell.collectionView.dataSource = self
            
            creditCell.creditLabel.text = indexPath.row == 1 ? "출연" : "다른 추천 시리즈"
            creditCell.collectionView.register(DramaCreditsCollectionViewCell.self, forCellWithReuseIdentifier: "DramaCreditsCollectionViewCell")
            creditCell.collectionView.reloadData()
            creditCell.collectionView.tag = indexPath.item

            return creditCell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            
            let text = list.overview
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: CGFloat.greatestFiniteMagnitude))
            label.text = text
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.sizeToFit()

            return label.frame.height + 350
            
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
