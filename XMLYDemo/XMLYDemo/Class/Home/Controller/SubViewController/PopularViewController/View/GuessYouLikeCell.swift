//
//  GuessYouLikeCell.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/22.
//  Copyright © 2016年 CoderST. All rights reserved.
//  猜你喜欢

import UIKit

class GuessYouLikeCell: UICollectionViewCell {
    
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
    
    var guessItem : HotSubModel?{
        didSet{
            iconImageView.sd_setImage( with: URL(string: guessItem?.albumCoverUrl290 ?? ""), placeholderImage: UIImage(named: "placeholder_image"))
            titleLabel.text = guessItem?.title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        titleLabel.preferredMaxLayoutWidth = contentView.bounds.width
        
        iconImageView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(contentView)
            make.height.width.equalTo(contentView.snp.width)
            
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.top.equalTo(iconImageView.snp.bottom)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
