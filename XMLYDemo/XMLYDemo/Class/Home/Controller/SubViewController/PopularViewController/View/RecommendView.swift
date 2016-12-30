//
//  RecommendView.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/22.
//  Copyright © 2016年 CoderST. All rights reserved.
//  轮播图下面的一排推荐

import UIKit
private let RecommendViewCellIdentifier = "RecommendViewCellIdentifier"
class RecommendView: UIView {

    var collectionView : UICollectionView!
    
    var discoveryColumns : [HotSubModel]?{
        didSet{
            guard let _ = discoveryColumns else { return }
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension RecommendView {
    
    fileprivate func setupUI() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 60, height: sRecommendHeight)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(RecommendViewCell.self, forCellWithReuseIdentifier: RecommendViewCellIdentifier)
        addSubview(collectionView)
    }
}

// MARK:- UICollectionViewDataSource
extension RecommendView : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return discoveryColumns?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendViewCellIdentifier, for: indexPath) as! RecommendViewCell
        let discoveryColumnsItem = discoveryColumns![indexPath.item]
        cell.discoveryColumnsItem = discoveryColumnsItem
        return cell
    }
    
}

// MARK:- UICollectionViewDelegate
extension RecommendView : UICollectionViewDelegate{
    

}
