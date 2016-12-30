//
//  STRefreshHeader.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/30.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit
import MJRefresh
class STRefreshHeader: MJRefreshHeader {

    // MARK:- 懒加载
    fileprivate  var catAnimationView : STCatAnimationView!

    override func prepare() {
        super.prepare()
        catAnimationView = STCatAnimationView()
        addSubview(catAnimationView)
        
        
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        
        catAnimationView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
        print(pullingPercent)
    }
    

    override var pullingPercent: CGFloat{
        
//        get{
//            
//           return catAnimationView.startAnimationWithProgress(progress: self.pullingPercent)
//        }
        
        didSet{
            catAnimationView.startAnimationWithProgress(progress: self.pullingPercent)
        }
 

    }
}
