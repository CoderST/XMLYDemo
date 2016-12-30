//
//  CategoryViewController.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/21.
//  Copyright © 2016年 CoderST. All rights reserved.
//  分类

import UIKit
private let CategoryHeadCellIdentifier = "CategoryHeadCellIdentifier"
private let CategoryNormalCellIdentifier = "CategoryNormalCellIdentifier"
private let headCellHeight : CGFloat = 160
class CategoryViewController: UIViewController {
    // MARK:- 属性
    fileprivate var collectionView : UICollectionView!

    // MARK:- 懒加载
    fileprivate lazy var categoryVM : CategoryViewModel = CategoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
//        getCategoryData()

    }

}

extension CategoryViewController {
    
    fileprivate func setupUI() {
        
        // 设置layout属性
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.footerReferenceSize = CGSize(width: stScreenW, height: 10)
        // 创建UICollectionView
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: stScreenH - 64 - 44 - 49), collectionViewLayout: layout)
        // 设置数据源
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        
        // 注册头部的cell
    
        collectionView.register(CategoryHeadCell.self, forCellWithReuseIdentifier: CategoryHeadCellIdentifier)
        collectionView.register(CategoryNormalCell.self, forCellWithReuseIdentifier: CategoryNormalCellIdentifier)
        
        // 注册普通cell
        view.addSubview(collectionView)
        
        //  设置刷新
        collectionView.mj_header = STRefreshHeader(refreshingTarget: self, refreshingAction: #selector(refreshHeaderAction))
        collectionView.mj_header.beginRefreshing()

    }
}
// MARK:- 网络请求
extension CategoryViewController {
    
    fileprivate func getCategoryData() {
        categoryVM.getCategoryData {
            
            self.collectionView.reloadData()
            self.collectionView.mj_header.endRefreshing()
        }
    }
}
// MARK:- 刷新相关
extension CategoryViewController {
    func refreshHeaderAction() {
        getCategoryData()
    }
}

extension CategoryViewController : UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        let count = categoryVM.groups.count
        
        return count 
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        

        let group = categoryVM.groups[section]
        return group.group.count 
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  
        let group = categoryVM.groups[indexPath.section]
        if indexPath.section == 0{
            let headCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryHeadCellIdentifier, for: indexPath) as! CategoryHeadCell
            headCell.categoryModel = group.group[indexPath.item]
            return headCell
        }else {
            let normalCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryNormalCellIdentifier, for: indexPath) as! CategoryNormalCell
            normalCell.indexPath = indexPath
            normalCell.categoryModel = group.group[indexPath.item]
            return normalCell
        }
}
}

extension CategoryViewController : UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if indexPath.section == 0{
           return CGSize(width: collectionView.bounds.width, height: headCellHeight)
        }else{
            
        }
        return CGSize(width: collectionView.bounds.width * 0.5, height: 44)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize{
            return CGSize(width: stScreenW, height: 10)
        
    }
}

