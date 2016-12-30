//
//  NowLiveSubCell.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/26.
//  Copyright © 2016年 CoderST. All rights reserved.
//  现场直播子cell

import UIKit
private let collectionViewHeight : CGFloat = 110
class NowLiveSubCell: UICollectionViewCell {
    
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
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.white
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(bottomLabel)
        
        iconImageView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(contentView)
            make.height.equalTo(collectionViewHeight)
            
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView)
            make.right.equalTo(iconImageView)
            make.top.equalTo(iconImageView.snp.bottom).offset(10)
        }
        
        bottomLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView)
            make.right.equalTo(iconImageView)
            make.bottom.equalTo(contentView).offset(-10)
        }
        
    }
    
    
    var nowLiveSubItem : HotSubModel?{
        
        didSet{
            iconImageView.sd_setImage( with: URL(string: nowLiveSubItem?.coverPath ?? ""), placeholderImage: UIImage(named: "placeholder_image"))
            
            titleLabel.text = nowLiveSubItem?.name
            bottomLabel.text = nowLiveSubItem?.shortDescription

        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
