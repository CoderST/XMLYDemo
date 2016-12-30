//
//  AnchorNormalCell.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/27.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class AnchorNormalCell: UICollectionViewCell {
    
    fileprivate lazy var bottomView : UIView = {
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.white
        return bottomView
        
    }()
    
    fileprivate lazy var bottomImageView : UIImageView = {
        
        let bottomImageView = UIImageView()
        bottomImageView.contentMode = .scaleAspectFill
        bottomImageView.image = UIImage(named: "find_person_6")
        bottomImageView.clipsToBounds = true
        return bottomImageView
        
    }()
 
    fileprivate lazy var iconImageView : UIImageView = {
        
        let iconImageView = UIImageView()
        iconImageView.backgroundColor = UIColor.blue
        iconImageView.layer.borderWidth = 1
        iconImageView.layer.borderColor = UIColor.gray.cgColor
        iconImageView.backgroundColor = UIColor.purple
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.clipsToBounds = true
        return iconImageView
        
    }()
    
    fileprivate lazy var titleLabel : UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.numberOfLines = 2
        titleLabel.textColor = UIColor.orange.withAlphaComponent(0.7)
        return titleLabel
        
    }()
    
    fileprivate lazy var detailLabel : UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.numberOfLines = 2
        return titleLabel
        
    }()
    var anchorModel : AnchorSectionList?{
        didSet{
            titleLabel.text = anchorModel?.nickname ?? ""
            detailLabel.text = anchorModel?.verifyTitle ?? ""
            iconImageView.sd_setImage(with: URL(string: anchorModel?.largeLogo ?? ""), placeholderImage: UIImage(named: "find_radio_default"))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor.white
        
        contentView.addSubview(detailLabel)
        contentView.addSubview(bottomImageView)
        bottomImageView.addSubview(iconImageView)
        bottomImageView.addSubview(titleLabel)
        
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.bottom.equalTo(contentView)
            make.height.equalTo(40)
        }
        
        bottomImageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView)
            make.left.equalTo(contentView)
            make.width.equalTo(contentView.bounds.width )
            make.bottom.equalTo(detailLabel.snp.top).offset(-10)

        }
        
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalTo(bottomImageView.snp.top).offset(5)
            make.centerX.equalTo(bottomImageView)
            make.width.height.equalTo(bottomImageView.snp.width).offset(-10)
        }
        
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView).offset(5)
            make.right.equalTo(iconImageView).offset(-5)
            make.bottom.equalTo(bottomImageView.snp.bottom).offset(-5)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
