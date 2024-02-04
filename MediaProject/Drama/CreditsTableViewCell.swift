//
//  CreditsTableViewCell.swift
//  MediaProject
//
//  Created by cho on 2/2/24.
//

import UIKit
import SnapKit

class CreditsTableViewCell: BaseTableViewCell {

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    let creditLabel = UILabel()
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 4, height: 130)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
    override func setAddView() {
        contentView.addSubviews([collectionView, creditLabel])
        collectionView.isUserInteractionEnabled = true
    }
    
    override func configureAttribute() {
        
        contentView.backgroundColor = .black
        collectionView.backgroundColor = .black
        
        creditLabel.text = "출연"
        creditLabel.textColor = .white
        creditLabel.backgroundColor = .black
    }
    
    override func configureLayout() {
        creditLabel.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(14)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(contentView.safeAreaLayoutGuide)
            make.top.equalTo(creditLabel.snp.bottom)
        }
        
        
        
        
    }
}
