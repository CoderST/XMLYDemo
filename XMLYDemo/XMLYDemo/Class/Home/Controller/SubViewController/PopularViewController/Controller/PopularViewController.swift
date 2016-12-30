//
//  PopularViewController.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/21.
//  Copyright © 2016年 CoderST. All rights reserved.
//  热门

import UIKit
/// 头部
private let reuseIdentifier = "reuseIdentifier"
/// 猜你喜欢
private let GuessYouLikeCellIdentifier = "GuessYouLikeCellIdentifier"
/// 普通
private let normalCellIdentifier = "normalCellIdentifier"
/// 现场直播
private let nowLiveCellIdentifier = "nowLiveCellIdentifier"
/// 推广
private let promotionCellIdentifier = "promotionCellIdentifier"
/// 精品听单
private let fineListenCellIdentifier = "fineListenCellIdentifier"

class PopularViewController: UIViewController {
    
    // MARK:- 变量
    var collectionView : UICollectionView!
    
    // MARK:- 懒加载
    fileprivate lazy var popularViewModel : PopularViewModel = PopularViewModel()
    // 轮播图的view
    fileprivate lazy var rotationMapView : RotationMapView = {
        
        let rotationMapView = RotationMapView()
        rotationMapView.frame = CGRect(x: 0, y: -(sRotationMapViewHeight + sRecommendHeight), width: stScreenW, height: sRotationMapViewHeight)
        return rotationMapView
        
    }()
    // 推荐的view
    fileprivate lazy var recommendView : RecommendView = RecommendView()
    // ReusableView
    fileprivate lazy var reusableView : PopularReusableView = PopularReusableView()
    
    // MARK:- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1 设置UI
        setupUI()
        // 2 网络请求
//        getPopularData()
        
        
    }
}
// MARK:- 设置UI
extension PopularViewController {
    fileprivate func setupUI() {
        setupCollectionView()
        
        setupRotationMapView()
        
        setupRecommendView()
        
        // 设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: sRotationMapViewHeight + sRecommendHeight, left: 0, bottom: 0, right: 0)
        
    }
    
    fileprivate func setupCollectionView() {
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
        collectionView.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        
        // 注册PopularReusableView
        collectionView.register(PopularReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseIdentifier)
        
        // 注册猜你喜欢cell
        collectionView.register(GuessYouLikeCell.self, forCellWithReuseIdentifier: GuessYouLikeCellIdentifier)
        
        // 注册精品,小编推荐类似的cell(普通的cell)
        collectionView.register(NormalCell.self, forCellWithReuseIdentifier: normalCellIdentifier)
        
        // 注册现场直播
        collectionView.register(NowLiveCell.self, forCellWithReuseIdentifier: nowLiveCellIdentifier)
        
        // 精品听单 FineListenCell
        collectionView.register(FineListenCell.self, forCellWithReuseIdentifier: fineListenCellIdentifier)
        
        // 注册推广 PromotionCell
        collectionView.register(PromotionCell.self, forCellWithReuseIdentifier: promotionCellIdentifier)
        view.addSubview(collectionView)
        
        //  设置刷新
        let refresh = STRefreshHeader(refreshingTarget: self, refreshingAction: #selector(refreshHeaderAction))
        collectionView.mj_header = refresh
        refresh!.ignoredScrollViewContentInsetTop = sRotationMapViewHeight + sRecommendHeight
        collectionView.mj_header.beginRefreshing()
    }
    
    fileprivate func setupRotationMapView() {
        collectionView.addSubview(rotationMapView)
        
    }
    
    fileprivate func setupRecommendView() {
        collectionView.addSubview(recommendView)
        recommendView.frame = CGRect(x: 0, y: -sRecommendHeight, width: stScreenW, height: sRecommendHeight)
        
    }
    
}

// MARK:- 获取网络数据
extension PopularViewController {
    func getPopularData() {
        popularViewModel.getData {
//            self.rotationMapView.focusImagesItems = self.popularViewModel.rotationMapModels
//            self.recommendView.discoveryColumns = self.popularViewModel.discoveryColumnsSubItem
            self.collectionView.reloadData()
            self.collectionView.mj_header.endRefreshing()
        }
    }
}

// MARK:- 刷新相关
extension PopularViewController {
    func refreshHeaderAction() {
        getPopularData()
    }
}

extension PopularViewController : UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        
        
        return popularViewModel.popularModels.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return popularViewModel.popularModels[section].list.count 
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = popularViewModel.popularModels[indexPath.section]
        if model.title == "猜你喜欢"{  // 猜你喜欢
            let guessYouLikeCell = collectionView.dequeueReusableCell(withReuseIdentifier: GuessYouLikeCellIdentifier, for: indexPath) as! GuessYouLikeCell
            guessYouLikeCell.guessItem = popularViewModel.caiNiXiHuanModels.first?.list[indexPath.item]
            return guessYouLikeCell
        }else if model.title == "精品听单"{  //  精品听单
            let fineListenCell = collectionView.dequeueReusableCell(withReuseIdentifier: fineListenCellIdentifier, for: indexPath) as! FineListenCell
            fineListenCell.fineListenSubItem = popularViewModel.jingPingTingDanModels.first?.list[indexPath.item]
            return fineListenCell
        }else if model.title == "现场直播"{ // 现场直播
            let nowLiveCell = collectionView.dequeueReusableCell(withReuseIdentifier: nowLiveCellIdentifier, for: indexPath) as! NowLiveCell
            nowLiveCell.nowLiveSubItem = popularViewModel.xianChagnZhiBoModels.first?.list
            return nowLiveCell
        }else if (model.title == "推广"){                          // 推广
            let promotionCell = collectionView.dequeueReusableCell(withReuseIdentifier: promotionCellIdentifier, for: indexPath) as! PromotionCell
            promotionCell.promotionSubItem = popularViewModel.popularModels[indexPath.section].list.first
            return promotionCell
            
        }else{
            
            let normalCell = collectionView.dequeueReusableCell(withReuseIdentifier: normalCellIdentifier, for: indexPath) as! NormalCell
            if indexPath.section == 2 {
                normalCell.hotRecommendsSubItem = popularViewModel.popularModels[indexPath.section].list[indexPath.item]
                return normalCell
            }else{
                normalCell.hotRecommendsSubItem = popularViewModel.popularModels[indexPath.section].list[indexPath.item]
                return normalCell
            }
        }
        
    }
}

extension PopularViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let model = popularViewModel.popularModels[indexPath.section]
        if model.title == "猜你喜欢"{  // 猜你喜欢
            return CGSize(width: sItemWidth, height: sGuessYouLikeItemHeight)
        }else if model.title == "精品听单"{  // 精品听单
            return CGSize(width: stScreenW, height: sTingDanItemHeight)
        }else if model.title == "推广"{   // 推广
            return CGSize(width: stScreenW, height: sNormalItemHeight)
        }else if model.title == "现场直播"{   // 现场直播
            return CGSize(width: stScreenW, height: sNormalItemHeight)
        }
        else{
            return CGSize(width: sItemWidth, height: sNormalItemHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifier, for: indexPath) as!PopularReusableView
        headerView.title = popularViewModel.popularModels[indexPath.section].title
        return headerView
    }
    
}
