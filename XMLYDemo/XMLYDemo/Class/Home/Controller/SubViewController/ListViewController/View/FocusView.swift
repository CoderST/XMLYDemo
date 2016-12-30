//
//  FocusCell.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/27.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class FocusView: UIView {
    
    fileprivate lazy var iconImageView : UIImageView = {
        
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.clipsToBounds = true
        return iconImageView
        
    }()

    
    var focusModel : FocusModel?{
        didSet{
            guard let focusModel = focusModel else { return }
            
            iconImageView.sd_setImage( with: URL(string: focusModel.pic ), placeholderImage: UIImage(named: "placeholder_image"))
            
        }
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints { (make) in
            make.left.top.bottom.right.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
