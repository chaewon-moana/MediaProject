//
//  DramaViewController.swift
//  MediaProject
//
//  Created by cho on 1/31/24.
//

import UIKit
import SnapKit
//37854 -> 원피스
class DramaViewController: BaseViewController{

    let dramaInfoTableView = UITableView()
    let titleLabel = UILabel()
    
    let tmdbManager = TMDBAPIManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tmdbManager.fetchDetailModel { model in
            print(model)
        }
    }
    
    override func setAddView() {
        view.addSubviews([dramaInfoTableView, titleLabel])
    }
    
    override func configureLayout() {
        
    }

    override func configureAttribute() {
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(28)
        }
        
        dramaInfoTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}
