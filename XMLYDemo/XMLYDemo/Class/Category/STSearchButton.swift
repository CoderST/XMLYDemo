//
//  STSearchButton.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/21.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class STSearchButton: UIButton {
    fileprivate lazy var searchIconImageView : UIImageView = {
        let searchIconImageView = UIImageView()
        searchIconImageView.contentMode = .center
        searchIconImageView.image = UIImage(named: "top_search_n")
        return searchIconImageView
    }()

    fileprivate lazy var placeHoldLabel : UILabel = {
        let placeHoldLabel = UILabel()
        placeHoldLabel.font = UIFont.systemFont(ofSize: 12)
        placeHoldLabel.textColor = UIColor.gray
        placeHoldLabel.text = "为什么你的声音不好听?"
        return placeHoldLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
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
        searchIconImageView.frame = CGRect(x: 5, y: 0, width: (font?.lineHeight)!, height: (font?.lineHeight)!)
        searchIconImageView.center = CGPoint(x: (font?.lineHeight)!, y: bounds.size.height * 0.5)
        placeHoldLabel.frame = CGRect(x: searchIconImageView.frame.maxX + 5, y: 0, width: bounds.width - searchIconImageView.frame.maxX - 5, height: bounds.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
