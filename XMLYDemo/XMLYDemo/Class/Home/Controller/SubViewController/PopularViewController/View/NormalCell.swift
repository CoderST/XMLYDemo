//
//  NormalCell.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/23.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class NormalCell: UICollectionViewCell {
    
    private lazy var iconImageView : UIImageView = {
        
        let iconImageView = UIImageView()
        iconImageView.contentMode = .ScaleAspectFill
        return iconImageView
        
    }()
    private lazy var trackTitleLabel : UILabel = {
        
        let trackTitleLabel = UILabel()
        trackTitleLabel.font = UIFont.systemFontOfSize(12)
        trackTitleLabel.numberOfLines = 2
        return trackTitleLabel
        
    }()
    
    private lazy var findImageView : UIImageView = {
       let findImageView = UIImageView()
        findImageView.contentMode = .ScaleAspectFill
        return findImageView
    }()
    
    private lazy var titleLabel : UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.grayColor()
        titleLabel.font = UIFont.systemFontOfSize(12)
        return titleLabel
        
    }()
    
    
    
    var hotRecommendsSubItem : HotRecommendsSubItem?{
        
        didSet{
            iconImageView.sd_setImageWithURL( NSURL(string: hotRecommendsSubItem?.albumCoverUrl290 ?? ""), placeholderImage: UIImage(named: "placeholder_image"))
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
        
        iconImageView.snp_makeConstraints { (make) in
            make.left.top.right.equalTo(contentView)
            make.height.equalTo(contentView.snp_width)
            
        }
        
        trackTitleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(contentView)
//            make.right.equalTo(contentView)
            make.top.equalTo(iconImageView.snp_bottom)
        }
        
        findImageView.snp_makeConstraints { (make) in
            make.left.equalTo(contentView).offset(5)
            make.bottom.equalTo(contentView.snp_bottom).offset(-7)
        }
        
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(findImageView.snp_right).offset(5)
            make.right.equalTo(contentView.snp_right).offset(-5)
            make.bottom.equalTo(contentView.snp_bottom).offset(-5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
