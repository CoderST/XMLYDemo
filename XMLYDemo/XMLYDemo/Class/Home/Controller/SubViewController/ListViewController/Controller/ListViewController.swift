//
//  5000 ListViewController.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/21.
//  Copyright © 2016年 CoderST. All rights reserved.
//  榜单

import UIKit
private let ListViewCellIdentifier = "ListViewCellIdentifier"
private let FocusViewReusableViewHeadIdentifier = "FocusViewReusableViewHeadIdentifier"
private let FocusViewReusableViewFootIdentifier = "FocusViewReusableViewFootIdentifier"
private let headCellHeight : CGFloat = 160
class ListViewController: UIViewController {
    
    fileprivate lazy var listVM : ListViewModel = ListViewModel()
    
    fileprivate lazy var focusView : FocusView = FocusView()
    // MARK:- 属性
    fileprivate var collectionView : UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
//        getListVCDate()
    }
    
    
    
}


extension ListViewController {
    
    fileprivate func setupUI() {
        // 1 设置collectionView
        setupCollectionView()
        // 2 设置焦点图
        setupFocusView()
        // 3 设置collectionView间距
        collectionView.contentInset = UIEdgeInsets(top: headCellHeight, left: 0, bottom: 0, right: 0)
        // 4 设置刷新
        let refresh = STRefreshHeader(refreshingTarget: self, refreshingAction: #selector(refreshHeaderAction))
        collectionView.mj_header = refresh
        refresh!.ignoredScrollViewContentInsetTop = headCellHeight
        collectionView.mj_header.beginRefreshing()
        
    }
    
    fileprivate func setupFocusView(){
        collectionView.addSubview(focusView)
        focusView.backgroundColor = UIColor.orange
        focusView.frame = CGRect(x: 0, y: -headCellHeight, width: collectionView.frame.width, height: headCellHeight)
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
        collectionView.register(ListHeadReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: FocusViewReusableViewHeadIdentifier)
        
        // foot
        collectionView.register(ListFootReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: FocusViewReusableViewFootIdentifier)
        
        // 注册展示cell
        collectionView.register(ListViewCell.self, forCellWithReuseIdentifier: ListViewCellIdentifier)
        
        // 注册普通cell
        view.addSubview(collectionView)

    }
}

// MARK:- 刷新相关
extension ListViewController {
    func refreshHeaderAction() {
        getListVCDate()
    }
}

extension ListViewController {
    
    fileprivate func getListVCDate() {
        
        listVM.getlistData {
            
            if let model = self.listVM.focusModelArray.first{
                
                self.focusView.focusModel = model
            }
            self.collectionView.reloadData()
            self.collectionView.mj_header.endRefreshing()
        }
    }
}

extension ListViewController : UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        let count = listVM.listModelArray.count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        let group = listVM.listModelArray[section]
        return group.list.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListViewCellIdentifier, for: indexPath) as! ListViewCell
            cell.listModel = listVM.listModelArray[indexPath.section].list[indexPath.item]
            return cell

        
    }
}

extension ListViewController : UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        

        return CGSize(width: collectionView.bounds.width, height: 75)
    }

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if kind == UICollectionElementKindSectionHeader{
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FocusViewReusableViewHeadIdentifier, for: indexPath) as!ListHeadReusableView
            headerView.title = listVM.listModelArray[indexPath.section].title
            return headerView
        }else {
            
            let footView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FocusViewReusableViewFootIdentifier, for: indexPath) as!ListFootReusableView
            return footView
        }

    }
}

