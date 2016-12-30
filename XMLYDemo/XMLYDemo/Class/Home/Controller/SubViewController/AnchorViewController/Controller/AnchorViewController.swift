//
//  AnchorViewController.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/21.
//  Copyright © 2016年 CoderST. All rights reserved.
//  主播

import UIKit
/// 普通
private let AnchorNormalCellIdentifier = "AnchorNormalCellIdentifier"
/// 歌手
private let AnchorSignerCellIdentifier = "AnchorSignerCellIdentifier"
/// 组头部
private let HeadReusableViewIdentifier = "HeadReusableViewIdentifier"
/// 组底部
private let FootReusableViewIdentifier = "FootReusableViewIdentifier"

class AnchorViewController: UIViewController {
    // MARK:- 懒加载
    fileprivate lazy var anchorVM : AnchorViewModel = AnchorViewModel()
    
    // MARK:- 属性
    fileprivate var collectionView : UICollectionView!
    
    // MARK:- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.randomColor()
        
        setupUI()
        
//        getAnchorData()
    }

}

// MARK:- UI
extension AnchorViewController {
    
    fileprivate func setupUI() {
        // 1 设置collectionView
        setupCollectionView()
        
    }
    
    
    fileprivate func setupCollectionView() {
        // 设置layout属性
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: stScreenW, height: sHeaderReferenceHeight)
                layout.footerReferenceSize = CGSize(width: stScreenW, height: 10)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        // 创建UICollectionView
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: stScreenH - 64 - 44 - 49), collectionViewLayout: layout)
        // 设置数据源
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        
        // 注册head
        collectionView.register(ListHeadReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeadReusableViewIdentifier)
        // foot
        collectionView.register(AnchorFootReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: FootReusableViewIdentifier)
        
        // 注册普通cell
        collectionView.register(AnchorNormalCell.self, forCellWithReuseIdentifier: AnchorNormalCellIdentifier)
        
        // 注册歌手cell
        collectionView.register(AnchorSignerCell.self, forCellWithReuseIdentifier: AnchorSignerCellIdentifier)
        
        view.addSubview(collectionView)
        
        // 添加刷新
        collectionView.mj_header = STRefreshHeader(refreshingTarget: self, refreshingAction: #selector(refreshHeaderAction))
        collectionView.mj_header.beginRefreshing()
    }
}

// MARK:- 刷新相关
extension AnchorViewController {
    func refreshHeaderAction() {
        getAnchorData()
    }
}

// MARK:- 网络请求
extension AnchorViewController {
    
    fileprivate func getAnchorData() {
        anchorVM.getAnchorData { 
            self.collectionView.reloadData()
            self.collectionView.mj_header.endRefreshing()
        }
    }
}
// MARK:- UICollectionViewDataSource
extension AnchorViewController : UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return anchorVM.anchorSections.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        let group = anchorVM.anchorSections[section]
        let count = group.list.count
        return (count - count % 3) 
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = anchorVM.anchorSections[indexPath.section]
        let modelDetail = model.list[indexPath.row]
        
        if model.displayStyle == 2{    // 歌手
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnchorSignerCellIdentifier, for: indexPath) as! AnchorSignerCell
            cell.singerModel = modelDetail
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AnchorNormalCellIdentifier, for: indexPath) as! AnchorNormalCell
            cell.anchorModel = modelDetail
            return cell
        }     
        
    }
}

extension AnchorViewController : UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let model = anchorVM.anchorSections[indexPath.section]
        if model.displayStyle == 2 {   // 歌手
            return CGSize(width: stScreenW, height: 90)
        }
        
        let width = stScreenW / 3.0
        let height = 32.0 * width / 21.0
        return CGSize(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出section的HeaderView
        if kind == UICollectionElementKindSectionHeader{
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeadReusableViewIdentifier, for: indexPath) as!ListHeadReusableView
            let model = anchorVM.anchorSections[indexPath.section]
                    headerView.title = model.title
            return headerView
        }else {
            
            let footView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FootReusableViewIdentifier, for: indexPath) as!AnchorFootReusableView
            //        headerView.title = listVM.listModelArray[indexPath.section].title
            return footView
        }
    }
}

