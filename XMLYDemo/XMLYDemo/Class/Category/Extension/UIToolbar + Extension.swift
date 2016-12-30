//
//  UIToolbar + Extension.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/30.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import Foundation
import UIKit

extension UIToolbar {
    /// 隐藏头部线
    func hideHairline() {
        let navigationBarImageView = hairlineImageViewInToolbar(view: self)
        navigationBarImageView!.isHidden = true
    }
    
    /// 显示头部线
    func showHairline() {
        let navigationBarImageView = hairlineImageViewInToolbar(view: self)
        navigationBarImageView!.isHidden = false
    }
    
    
    /// 实现方法
    private func hairlineImageViewInToolbar(view: UIView) -> UIImageView? {
        if view.isKind(of : UIImageView.self) && view.bounds.height <= 1.0 {
            return (view as! UIImageView)
        }
        
        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView: UIImageView = hairlineImageViewInToolbar(view: subview) {
                return imageView
            }
        }
        
        return nil
    }
    
}
