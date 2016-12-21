//
//  STSearchButton.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/21.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class STSearchButton: UIButton {
    private lazy var searchIconImageView : UIImageView = {
        let searchIconImageView = UIImageView()
        searchIconImageView.contentMode = .Center
        searchIconImageView.image = UIImage(named: "top_search_n")
        return searchIconImageView
    }()

    private lazy var placeHoldLabel : UILabel = {
        let placeHoldLabel = UILabel()
        placeHoldLabel.font = UIFont.systemFontOfSize(12)
        placeHoldLabel.textColor = UIColor.grayColor()
        placeHoldLabel.text = "为什么你的声音不好听?"
        return placeHoldLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        addSubview(searchIconImageView)
        addSubview(placeHoldLabel)
        
        layer.cornerRadius = bounds.height * 0.5
        clipsToBounds = true
        
    }
    
    
    var placeHold : String?{
        
        didSet{
            placeHoldLabel.text = placeHold
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let font = placeHoldLabel.font
        print(font.lineHeight)
        searchIconImageView.frame = CGRect(x: 5, y: 0, width: font.lineHeight, height: font.lineHeight)
        searchIconImageView.center = CGPoint(x: font.lineHeight, y: bounds.size.height * 0.5)
        placeHoldLabel.frame = CGRect(x: CGRectGetMaxX(searchIconImageView.frame) + 5, y: 0, width: bounds.width - CGRectGetMaxX(searchIconImageView.frame) - 5, height: bounds.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
