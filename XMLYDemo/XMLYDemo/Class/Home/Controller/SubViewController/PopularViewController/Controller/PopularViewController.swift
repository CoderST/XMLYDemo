//
//  PopularViewController.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/21.
//  Copyright © 2016年 CoderST. All rights reserved.
//  热门

import UIKit
private let GuessYouLikeCellIdentifier = "GuessYouLikeCellIdentifier"
private let reuseIdentifier = "reuseIdentifier"
private let normalCellIdentifier = "normalCellIdentifier"
class PopularViewController: UIViewController {
    
    // MARK:- 变量
    var collectionView : UICollectionView!
    
    // MARK:- 懒加载
    private lazy var popularVM : PopularVM = PopularVM()
    // 轮播图的view
    private lazy var rotationMapView : RotationMapView = {
        
        let rotationMapView = RotationMapView()
        rotationMapView.frame = CGRect(x: 0, y: -(sRotationMapViewHeight + sRecommendHeight), width: stScreenW, height: sRotationMapViewHeight)
        return rotationMapView
        
    }()
    // 推荐的view
    private lazy var recommendView : RecommendView = RecommendView()
    // ReusableView
    private lazy var reusableView : PopularReusableView = PopularReusableView()
    
    // MARK:- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        getRotationMapViewData()
        getMainDatas()
        
        
    }
}
// MARK:- 设置UI
extension PopularViewController {
    private func setupUI() {
        setupCollectionView()
        
        setupRotationMapView()
        
        setupRecommendView()
        
        // 设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: sRotationMapViewHeight + sRecommendHeight, left: 0, bottom: 0, right: 0)
        
    }
    
    private func setupCollectionView() {
        // 设置layout属性
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: stScreenW, height: sHeaderReferenceHeight)
        layout.minimumInteritemSpacing = sMargin
        layout.minimumLineSpacing = sMargin
        layout.sectionInset = UIEdgeInsets(top: sMargin, left: sMargin, bottom: sMargin, right: sMargin)
        
        // 创建UICollectionView
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: stScreenH - 64 - 44 - 49), collectionViewLayout: layout)
        // 设置数据源
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.whiteColor()
        
        collectionView.backgroundColor = UIColor.purpleColor()
        
        // 注册猜你喜欢cell
        collectionView.registerClass(GuessYouLikeCell.self, forCellWithReuseIdentifier: GuessYouLikeCellIdentifier)
        
        // 注册精品,小编推荐类似的cell(普通的cell)
        collectionView.registerClass(NormalCell.self, forCellWithReuseIdentifier: normalCellIdentifier)
        
        // 注册PopularReusableView
        collectionView.registerClass(PopularReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseIdentifier)
        
        view.addSubview(collectionView)
    }
    
    private func setupRotationMapView() {
        collectionView.addSubview(rotationMapView)
        
    }
    
    private func setupRecommendView() {
        collectionView.addSubview(recommendView)
        recommendView.frame = CGRect(x: 0, y: -sRecommendHeight, width: stScreenW, height: sRecommendHeight)
        
    }
    
}

// MARK:- 获取网络数据
extension PopularViewController {
    
    func getRotationMapViewData() {
        popularVM.getRecommendsIncludeActivityData {
            let focusImages = self.popularVM.focusImagesModel?.list
            self.rotationMapView.focusImagesItems = focusImages
        }
    }
    
    func getMainDatas() {
        popularVM.getMainDatas {
            // 给推荐view传递数据
            self.recommendView.discoveryColumns = self.popularVM.discoverModel
            self.collectionView.reloadData()
        }
    }
}


extension PopularViewController : UICollectionViewDataSource {
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0{
            
            return popularVM.guessModel?.list.count ?? 0
        }
        else{
            
            return popularVM.hotRecommendsModel?.list.first?.list.count ?? 0
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0{
            
            let guessYouLikeCell = collectionView.dequeueReusableCellWithReuseIdentifier(GuessYouLikeCellIdentifier, forIndexPath: indexPath) as! GuessYouLikeCell
            // 传递模型
            guessYouLikeCell.guessItem = popularVM.guessModel!.list[indexPath.item]
            guessYouLikeCell.contentView.backgroundColor = UIColor.randomColor()
            return guessYouLikeCell
        }else{
            let normalCell = collectionView.dequeueReusableCellWithReuseIdentifier(normalCellIdentifier, forIndexPath: indexPath) as! NormalCell
            normalCell.contentView.backgroundColor = UIColor.randomColor()
            normalCell.hotRecommendsSubItem = popularVM.hotRecommendsModel?.list.first?.list[indexPath.item]
            return normalCell
        }
        
    }
    
    
}

extension PopularViewController : UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.section == 0{
            
            return CGSize(width: sItemWidth, height: sGuessYouLikeItemHeight)
        }else {
            return CGSize(width: sItemWidth, height: sNormalItemHeight)
        }
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        // 1.取出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: reuseIdentifier, forIndexPath: indexPath) as!PopularReusableView
        if indexPath.section == 0{
            
            headerView.title = popularVM.guessModel?.title
        }else{
            headerView.title = popularVM.hotRecommendsModel?.list.first?.title
        }
        return headerView
    }
    
}
