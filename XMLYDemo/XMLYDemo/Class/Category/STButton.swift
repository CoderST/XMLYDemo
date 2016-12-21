//
//  STButton.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/21.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit
private let buttonScale : CGFloat = 0.65
class STButton: UIButton {

    /// 重写父类方法,禁止按钮选中高亮状态
    override var highlighted: Bool {
        
        get{ return false }
        
        set {
            
        }
        
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView?.contentMode = .Center
        titleLabel?.textAlignment = .Center
        titleLabel?.font = UIFont.systemFontOfSize(12)
        setTitleColor(iOS7 ? UIColor.blackColor() : UIColor.orangeColor(), forState: .Normal)
        setTitleColor(iOS7 ? UIColor.redColor() : UIColor.purpleColor(), forState: .Selected)
        
    }
    
    
    
    class func creatButton(item : UITabBarItem)->STButton?{
        let button = STButton(type: .Custom)
        guard let normalImage = item.image else { return nil }
        guard let selectedImage = item.selectedImage else { return nil }
        button.setImage(normalImage, forState: .Normal)
        button.setImage(selectedImage, forState: .Selected)
        button.setTitle(item.title, forState: .Normal)
        return button
    }
    
    
    
//    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
//        let  imageW = contentRect.size.width;
//        let imageH = contentRect.size.height * buttonScale;
//        return CGRectMake(0, 0, imageW, imageH);
//    }
//    
//    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
//        let titleY = contentRect.size.height * buttonScale;
//        let titleW = contentRect.size.width;
//        let titleH = contentRect.size.height - titleY;
//        return CGRectMake(0, titleY, titleW, titleH);
//    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
