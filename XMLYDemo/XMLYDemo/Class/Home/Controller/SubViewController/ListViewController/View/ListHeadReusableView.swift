//
//  FocusViewReusableView.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/27.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class ListHeadReusableView: UICollectionReusableView {
    
//    var indexPath : NSIndexPath?
    
    fileprivate lazy var bottomView : UIView = UIView()
    
    fileprivate lazy var iconImageView : UIImageView = UIImageView()
    
    fileprivate lazy var titleLabel : UILabel = UILabel()
    
    fileprivate lazy var moreLabel : UILabel = UILabel()
    
    var title : String?{
        didSet{
            guard let title = title else { return }
            
//            if indexPath?.section == 0{
//                bottomView.snp_updateConstraints(closure: { (make) in
//                    make.top.equalTo(self)
//                })
//          
//            }else{
//                bottomView.snp_updateConstraints(closure: { (make) in
//                    make.top.equalTo(self).offset(10)
//                })
//         
//            }
            
            titleLabel.text = title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.gray
        
        addSubview(bottomView)
        bottomView.backgroundColor = UIColor.white
        
        bottomView.addSubview(iconImageView)
        iconImageView.image = UIImage(named: "liveRadioCellPoint")
        
        bottomView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.black
        titleLabel.text = ""
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        
        bottomView.addSubview(moreLabel)
        moreLabel.text = "更多"
        moreLabel.font = titleLabel.font
        moreLabel.textColor = UIColor.black
        
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.right.bottom.equalTo(self)
        }
        
        iconImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(bottomView)
            make.left.equalTo(10)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(5)
            make.centerY.equalTo(bottomView)
        }
        
        moreLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(bottomView)
            make.right.equalTo(-10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
