//
//  PopularReusableView.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/22.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class PopularReusableView: UICollectionReusableView {
    
    private lazy var bottomView : UIView = UIView()
    
    private lazy var iconImageView : UIImageView = UIImageView()
    
    private lazy var titleLabel : UILabel = UILabel()
    
    private lazy var moreLabel : UILabel = UILabel()
    
    var title : String?{
        didSet{
            guard let title = title else { return }
            titleLabel.text = title
            print("mmmm",titleLabel.text)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.grayColor()
        
        addSubview(bottomView)
        bottomView.backgroundColor = UIColor.whiteColor()
        
        bottomView.addSubview(iconImageView)
        iconImageView.image = UIImage(named: "liveRadioCellPoint")
        
        bottomView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.text = ""
        titleLabel.font = UIFont.systemFontOfSize(14)
        
        bottomView.addSubview(moreLabel)
        moreLabel.text = "更多"
        moreLabel.font = titleLabel.font
        moreLabel.textColor = UIColor.blackColor()
        
        bottomView.snp_makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.right.bottom.equalTo(self)
        }
        
        iconImageView.snp_makeConstraints { (make) in
            make.centerY.equalTo(bottomView)
            make.left.equalTo(10)
        }
        
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp_right).offset(5)
            make.centerY.equalTo(bottomView)
        }
        
        moreLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(bottomView)
            make.right.equalTo(-10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
