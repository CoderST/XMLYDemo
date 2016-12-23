//
//  RotationMapView.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/22.
//  Copyright © 2016年 CoderST. All rights reserved.
//  轮播图

import UIKit
private let RotationMapCollectionViewCellIdentifier = "RotationMapCollectionViewCellIdentifier"
class RotationMapView: UIView {

    var collectionView : UICollectionView!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    // MARK:- 属性
    var focusImagesItemTime : NSTimer?
    
    var focusImagesItems : [FocusImagesItem]?{
        didSet{
            
            guard let focusImagesItems = focusImagesItems else { return }
            
            collectionView.reloadData()
            // 3.默认滚动到中间某一个位置
            let indexPath = NSIndexPath(forItem: focusImagesItems.count * 10, inSection: 0)
            collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: false)
            
            
            // 定时器操作
            removeTime()
            addTime()
            
        }
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension RotationMapView {
    
    private func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.pagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(RotationMapCollectionViewCell.self, forCellWithReuseIdentifier: RotationMapCollectionViewCellIdentifier)
        addSubview(collectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
        let layout = collectionView.collectionViewLayout as!UICollectionViewFlowLayout
        layout.itemSize = bounds.size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
    }
}


// MARK:- UICollectionViewDataSource
extension RotationMapView : UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (focusImagesItems?.count ?? 0) * 10000
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cycleCell = collectionView.dequeueReusableCellWithReuseIdentifier(RotationMapCollectionViewCellIdentifier, forIndexPath: indexPath) as! RotationMapCollectionViewCell
        let focusImagesItem = focusImagesItems![indexPath.item % (focusImagesItems?.count ?? 0)]
        cycleCell.focusImagesItem = focusImagesItem
        return cycleCell
    }
    
}

// MARK:- UICollectionViewDelegate
extension RotationMapView : UICollectionViewDelegate{
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        removeTime()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTime()
    }
}

// MARK:- 定时器相关
extension RotationMapView {
    
    // 创建定时器
    private func addTime(){
        focusImagesItemTime = NSTimer(timeInterval: 3.0, target: self, selector: "scrollToNextPage", userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(focusImagesItemTime!, forMode: NSRunLoopCommonModes)
    }
    
    private func removeTime(){
        focusImagesItemTime?.invalidate()
        focusImagesItemTime = nil
    }
    
    @objc private func scrollToNextPage(){
        // 获取当前的偏移量
        let offSet = collectionView.contentOffset.x
        // 即将要滚动的偏移量
        let newOffSet = offSet + collectionView.bounds.width
        // 开始滚动
        collectionView.setContentOffset(CGPointMake(newOffSet, 0), animated: true)
    }
}

