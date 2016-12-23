//
//  GuessYouLikeCell.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/22.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class GuessYouLikeCell: UICollectionViewCell {
    
    private lazy var iconImageView : UIImageView = {
       
        let iconImageView = UIImageView()
        iconImageView.contentMode = .ScaleAspectFill
        return iconImageView
        
    }()
    
    private lazy var titleLabel : UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFontOfSize(12)
        titleLabel.numberOfLines = 2
        return titleLabel
        
    }()
    
    var guessItem : GuessItem?{
        didSet{
            iconImageView.sd_setImageWithURL( NSURL(string: guessItem?.albumCoverUrl290 ?? ""), placeholderImage: UIImage(named: "placeholder_image"))
            titleLabel.text = guessItem?.title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        titleLabel.preferredMaxLayoutWidth = contentView.bounds.width
        
        iconImageView.snp_makeConstraints { (make) in
            make.left.top.right.equalTo(contentView)
            make.height.equalTo(contentView.snp_width)
            
        }
        
        titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.top.equalTo(iconImageView.snp_bottom)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
