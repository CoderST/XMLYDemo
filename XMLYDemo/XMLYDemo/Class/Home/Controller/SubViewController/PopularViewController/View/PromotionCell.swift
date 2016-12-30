//
//  PromotionCell.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/26.
//  Copyright © 2016年 CoderST. All rights reserved.
//  推广

import UIKit
private let iconImageViewHeight : CGFloat = 110
class PromotionCell: UICollectionViewCell {

    fileprivate lazy var iconImageView : UIImageView = {
        
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.clipsToBounds = true
        return iconImageView
        
    }()
    fileprivate lazy var titleLabel : UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.numberOfLines = 2
        return titleLabel
        
    }()
    
    fileprivate lazy var playCountLabel : UILabel = {
        
        let playCountLabel = UILabel()
        playCountLabel.font = UIFont.systemFont(ofSize: 12)
        return playCountLabel
        
    }()
    
    fileprivate lazy var bottomLabel : UILabel = {
        
        let bottomLabel = UILabel()
        bottomLabel.font = UIFont.systemFont(ofSize: 12)
        bottomLabel.textColor = UIColor.gray
        return bottomLabel
        
    }()
    

    var promotionSubItem : HotSubModel?{
        
        didSet{
            iconImageView.sd_setImage( with: URL(string: promotionSubItem?.cover ?? ""), placeholderImage: UIImage(named: "placeholder_image"))
            titleLabel.text = promotionSubItem?.name
            bottomLabel.text = promotionSubItem?.mydescription
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playCountLabel)
        contentView.addSubview(bottomLabel)
        
        iconImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.height.equalTo(iconImageViewHeight)
            make.width.equalTo(stScreenW - 20)
            
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView)
            make.right.equalTo(iconImageView)
            make.top.equalTo(iconImageView.snp.bottom).offset(5)
        }
        
        bottomLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView)
            make.right.equalTo(iconImageView)
            make.bottom.equalTo(contentView).offset(-10)
        }

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
