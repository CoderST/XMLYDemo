//
//  CategoryHeadCell.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/27.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class CategoryHeadCell: UICollectionViewCell {
 
    fileprivate lazy var iconImageView : UIImageView = {
        
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.clipsToBounds = true
        return iconImageView
        
    }()
    
    var categoryModel : CategoryModel?{
        didSet{
            iconImageView.sd_setImage( with: URL(string: categoryModel?.coverPath ?? ""), placeholderImage: UIImage(named: "placeholder_image"))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(contentView)
            
        }

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
