//
//  RotationMapCollectionViewCell.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/22.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit
import SDWebImage
class RotationMapCollectionViewCell: UICollectionViewCell {
    
    private lazy var fourceImageView : UIImageView = {
       
        let fourceImageView = UIImageView()
        fourceImageView.contentMode = .ScaleToFill
        
        return fourceImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(fourceImageView)
    }
    
    
    var focusImagesItem : FocusImagesItem?{
        didSet{
            fourceImageView.sd_setImageWithURL(NSURL(string: focusImagesItem?.pic ?? ""), placeholderImage: UIImage(named: "cirle_image_place"))
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
