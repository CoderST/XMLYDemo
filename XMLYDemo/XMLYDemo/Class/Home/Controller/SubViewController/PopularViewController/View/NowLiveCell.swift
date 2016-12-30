//
//  NowLiveCell.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/26.
//  Copyright © 2016年 CoderST. All rights reserved.
//  现场直播

import UIKit

private let NowLiveSubCellIdentifier = "NowLiveSubCellIdentifier"
class NowLiveCell: UICollectionViewCell {
    
    // MARK:- 属性
    var newLiveItemTime : Timer?
    
    fileprivate lazy var collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        return collectionView
        
    }()
    
    var nowLiveSubItem : [HotSubModel]?{
        
        didSet{
            guard let nowLiveSubItem = nowLiveSubItem else { return }
            
            collectionView.reloadData()
            // 3.默认滚动到中间某一个位置
            let indexPath = IndexPath(item: nowLiveSubItem.count * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            
            // 定时器操作
            removeTime()
            addTime()
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(NowLiveSubCell.self, forCellWithReuseIdentifier: NowLiveSubCellIdentifier)
        contentView.addSubview(collectionView)
        
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //没用snp约束,用了之后发现在调用定时器方法滚动后,会在边缘多出10的间隙!!!????
        collectionView.frame = CGRect(x: 10, y: 10, width: stScreenW - 20, height: bounds.height)
        let layout = collectionView.collectionViewLayout as!UICollectionViewFlowLayout
        print("kkkkkkkkkk",collectionView.frame.size)
        layout.itemSize = collectionView.frame.size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


// MARK:- UICollectionViewDataSource
extension NowLiveCell : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (nowLiveSubItem?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cycleCell = collectionView.dequeueReusableCell(withReuseIdentifier: NowLiveSubCellIdentifier, for: indexPath) as! NowLiveSubCell
        let focusImagesItem = nowLiveSubItem?[indexPath.item % (nowLiveSubItem?.count ?? 0)]
        cycleCell.nowLiveSubItem = focusImagesItem
        return cycleCell
    }
    
}

// MARK:- UICollectionViewDelegate
extension NowLiveCell : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        removeTime()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTime()
    }
}

// MARK:- 定时器相关
extension NowLiveCell {
    
    // 创建定时器
    fileprivate func addTime(){
        newLiveItemTime = Timer(timeInterval: 3.0, target: self, selector: #selector(NowLiveCell.scrollToNextPage), userInfo: nil, repeats: true)
        RunLoop.main.add(newLiveItemTime!, forMode: RunLoopMode.commonModes)
    }
    
    fileprivate func removeTime(){
        newLiveItemTime?.invalidate()
        newLiveItemTime = nil
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


