//
//  RecommendViewCell.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/22.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit
import SnapKit
private let iconWH : CGFloat = 40
class RecommendViewCell: UICollectionViewCell {
    
    fileprivate lazy var iconImageView : UIImageView = UIImageView()
    fileprivate lazy var titleLabel : UILabel = UILabel()
    
    var discoveryColumnsItem : HotSubModel?{
        
        didSet{
           
            iconImageView.sd_setImage( with: URL(string: discoveryColumnsItem?.coverPath ?? ""), placeholderImage: UIImage(named: "placeholder_image"))
            titleLabel.text = discoveryColumnsItem?.title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        
        iconImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(10)
            make.size.equalTo(CGSize(width: iconWH, height: iconWH))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.bottom.equalTo(-5)
            make.width.equalTo(contentView)
            make.height.equalTo(20)
        }
        
        iconImageView.contentMode = .scaleAspectFit
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = UIColor.gray
        
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        let imageViewHeight = bounds.height * 0.7
//        
//        iconImageView.frame = CGRect(x: 0, y: 10, width: bounds.width, height: imageViewHeight)
//        titleLabel.frame = CGRect(x: 0, y: CGRectGetMaxY(iconImageView.frame), width: bounds.width, height: bounds.height - CGRectGetMaxY(iconImageView.frame))
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
