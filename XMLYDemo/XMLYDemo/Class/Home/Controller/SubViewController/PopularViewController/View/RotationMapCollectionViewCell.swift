//
//  RotationMapCollectionViewCell.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/22.
//  Copyright © 2016年 CoderST. All rights reserved.
//  轮播图cell

import UIKit
import SDWebImage
class RotationMapCollectionViewCell: UICollectionViewCell {
    
    fileprivate lazy var fourceImageView : UIImageView = {
       
        let fourceImageView = UIImageView()
        fourceImageView.contentMode = .scaleToFill
        
        return fourceImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(fourceImageView)
    }
    
    
    var focusImagesItem : HotSubModel?{
        didSet{
            fourceImageView.sd_setImage(with: URL(string: focusImagesItem?.pic ?? ""), placeholderImage: UIImage(named: "cirle_image_place"))
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        fourceImageView.frame = contentView.bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
