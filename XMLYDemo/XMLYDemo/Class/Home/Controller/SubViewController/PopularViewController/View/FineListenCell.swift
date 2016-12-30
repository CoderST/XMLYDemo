//
//  FineListenCell.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/26.
//  Copyright © 2016年 CoderST. All rights reserved.
//  精品听单

import UIKit

class FineListenCell: UICollectionViewCell {
    
    fileprivate lazy var iconImageView : UIImageView = {
        
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFill
        return iconImageView
        
    }()
    fileprivate lazy var titleLabel : UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.numberOfLines = 2
        return titleLabel
        
    }()
    
    fileprivate lazy var subtitle : UILabel = {
        
        let subtitle = UILabel()
        subtitle.font = UIFont.systemFont(ofSize: 12)
        return subtitle
        
    }()
    
    fileprivate lazy var bottomLabel : UILabel = {
        
        let bottomLabel = UILabel()
        bottomLabel.font = UIFont.systemFont(ofSize: 12)
        return bottomLabel
        
    }()

    
    var fineListenSubItem : HotSubModel?{
        
        didSet{
            iconImageView.sd_setImage( with: URL(string: fineListenSubItem?.coverPath ?? ""), placeholderImage: UIImage(named: "placeholder_image"))
            titleLabel.text = fineListenSubItem?.title
            subtitle.text = fineListenSubItem?.subtitle
            bottomLabel.text = fineListenSubItem?.footnote
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitle)
        contentView.addSubview(bottomLabel)
        
        iconImageView.snp.makeConstraints { (make) in
            make.left.top.equalTo(contentView).offset(10)
            make.height.width.equalTo(sTingDanItemHeight - 20)
            
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.top.equalTo(iconImageView)
        }
        
        subtitle.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.right.equalTo(titleLabel)
            make.centerY.equalTo(iconImageView)
        }
        
        bottomLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.right.lessThanOrEqualTo(contentView.snp.right).offset(-10)
            make.bottom.equalTo(iconImageView)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
