//
//  CategoryNormalCell.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/27.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class CategoryNormalCell: UICollectionViewCell {
    
    var indexPath : IndexPath?
    
    fileprivate lazy var iconImageView : UIImageView = {
        
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.clipsToBounds = true
        return iconImageView
        
    }()

    fileprivate lazy var titleLabel : UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.numberOfLines = 2
        return titleLabel
        
    }()
    
    fileprivate lazy var lineView : UIView = {
       let lineView = UIView()
        lineView.backgroundColor = UIColor.lightGray
        
        return lineView
    }()
    
    
    
    var categoryModel : CategoryModel?{
        didSet{
            guard let categoryModel = categoryModel else { return }
            iconImageView.sd_setImage( with: URL(string: categoryModel.coverPath), placeholderImage: UIImage(named: "placeholder_image"))
            titleLabel.text = categoryModel.title
            
            if indexPath!.item % 2 == 0{
                lineView.isHidden = true
            }else{
                lineView.isHidden = false
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.white
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(lineView)
        
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(contentView).offset(40)
            make.bottom.equalTo(contentView).offset(-10)
            make.width.equalTo(contentView.bounds.height - 20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.top.equalTo(contentView)
            make.height.equalTo(contentView)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView).offset(-10)
            make.left.equalTo(contentView)
            make.width.equalTo(1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
