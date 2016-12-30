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
    var focusImagesItemTime : Timer?
    
    var focusImagesItems : [HotSubModel]?{
        didSet{
            
            guard let focusImagesItems = focusImagesItems else { return }
            
            collectionView.reloadData()
            // 3.默认滚动到中间某一个位置
            let indexPath = IndexPath(item: focusImagesItems.count * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            
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
    
    fileprivate func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(RotationMapCollectionViewCell.self, forCellWithReuseIdentifier: RotationMapCollectionViewCellIdentifier)
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (focusImagesItems?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cycleCell = collectionView.dequeueReusableCell(withReuseIdentifier: RotationMapCollectionViewCellIdentifier, for: indexPath) as! RotationMapCollectionViewCell
        let focusImagesItem = focusImagesItems![indexPath.item % (focusImagesItems?.count ?? 0)]
        cycleCell.focusImagesItem = focusImagesItem
        return cycleCell
    }
    
}

// MARK:- UICollectionViewDelegate
extension RotationMapView : UICollectionViewDelegate{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        removeTime()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTime()
    }
}

// MARK:- 定时器相关
extension RotationMapView {
    
    // 创建定时器
    fileprivate func addTime(){
        focusImagesItemTime = Timer(timeInterval: 3.0, target: self, selector: #selector(RotationMapView.scrollToNextPage), userInfo: nil, repeats: true)
        RunLoop.main.add(focusImagesItemTime!, forMode: RunLoopMode.commonModes)
    }
    
    fileprivate func removeTime(){
        focusImagesItemTime?.invalidate()
        focusImagesItemTime = nil
    }
    
    @objc fileprivate func scrollToNextPage(){
        // 获取当前的偏移量
        let offSet = collectionView.contentOffset.x
        // 即将要滚动的偏移量
        let newOffSet = offSet + collectionView.bounds.width
        // 开始滚动
        collectionView.setContentOffset(CGPoint(x: newOffSet, y: 0), animated: true)
    }
}

