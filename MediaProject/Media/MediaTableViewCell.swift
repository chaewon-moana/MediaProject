//
//  MediaTableViewCell.swift
//  MediaProject
//
//  Created by cho on 1/31/24.
//

import UIKit
import SnapKit

class MediaTableViewCell: BaseTableViewCell {

    let categoryLabel = UILabel()
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: setUICollectionViewLayout())
        return view
    }()
    
    override func setAddView() {
        contentView.addSubview(categoryLabel)
        contentView.addSubview(collectionView)
    }
    
    override func configureLayout() {
        categoryLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(24)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(contentView.safeAreaLayoutGuide)
            make.top.equalTo(categoryLabel.snp.bottom)
        }
    }
    
    override func configureAttribute() {
        categoryLabel.text = "테스트용 카테고리 라벨"
        categoryLabel.textColor = .white
        categoryLabel.backgroundColor = .black
        
        collectionView.backgroundColor = .black
    }
    
    func setUICollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 160)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        
        return layout
    }
}


