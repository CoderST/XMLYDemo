//
//  NormalCell.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/23.
//  Copyright © 2016年 CoderST. All rights reserved.
//  普通cell

import UIKit

class NormalCell: UICollectionViewCell {
    
    fileprivate lazy var iconImageView : UIImageView = {
        
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFill
        return iconImageView
        
    }()
    fileprivate lazy var trackTitleLabel : UILabel = {
        
        let trackTitleLabel = UILabel()
        trackTitleLabel.font = UIFont.systemFont(ofSize: 12)
        trackTitleLabel.numberOfLines = 2
        return trackTitleLabel
        
    }()
    
    fileprivate lazy var findImageView : UIImageView = {
       let findImageView = UIImageView()
        findImageView.contentMode = .scaleAspectFill
        return findImageView
    }()
    
    fileprivate lazy var titleLabel : UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.gray
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        return titleLabel
        
    }()
    
    
    
    var hotRecommendsSubItem : HotSubModel?{
        
        didSet{
            iconImageView.sd_setImage( with: URL(string: hotRecommendsSubItem?.albumCoverUrl290 ?? ""), placeholderImage: UIImage(named: "placeholder_image"))
            trackTitleLabel.text = hotRecommendsSubItem?.trackTitle
            titleLabel.text = hotRecommendsSubItem?.title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(trackTitleLabel)
        contentView.addSubview(findImageView)
        contentView.addSubview(titleLabel)
        findImageView.image = UIImage(named: "find_specialicon")
        trackTitleLabel.preferredMaxLayoutWidth = contentView.bounds.width - 5
        
        iconImageView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(contentView)
            make.height.equalTo(contentView.snp.width)
            
        }
        
        trackTitleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView)
//            make.right.equalTo(contentView)
            make.top.equalTo(iconImageView.snp.bottom)
        }
        
        findImageView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(5)
            make.bottom.equalTo(contentView.snp.bottom).offset(-7)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(findImageView.snp.right).offset(5)
            make.right.equalTo(contentView.snp.right).offset(-5)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
