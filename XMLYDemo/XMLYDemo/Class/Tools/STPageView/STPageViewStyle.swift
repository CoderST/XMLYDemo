//
//  STPageViewStyle.swift
//  STPageView
//
//  Created by xiudou on 2016/12/5.
//  Copyright © 2016年 CoderST. All rights reserved.
//  所有的样式

import UIKit
let STNSNotificationCenter = NotificationCenter.default
let DIDSELECTED_MENUM_TYPE = "didSelectedMenuType"
let STNSUserDefaults = UserDefaults.standard
let HOMETYPE = "homeType"
class STPageViewStyle {
    /***************** titleView相关设置 ******************/
     // titleView高度
    var titleViewHeight : CGFloat = 44
    // 标题普通状态下的文字
    var normalColor : UIColor = UIColor(r: 0, g: 0, b: 0)
    // 标题选中状态下的文字
    var selectColor : UIColor = UIColor(r: 255, g: 127, b: 0)
    // 标题的字体大小
    var fontSize : CGFloat = 15.0
    var titleViewBackgroundColor : UIColor = UIColor.clear
    
    /// 是否进行缩放
    var isNeedScale : Bool = false
    var scaleRange : CGFloat = 1.2
    /***************** titleView相关设置 ******************/
     
     
     
     /***************** 底部滚动条相关设置 ******************/
     // 是否可以滚动
    var isScrollEnable : Bool = false
    // 是否显示底部滚动条
    var isShowScrollLine : Bool = false
    var bottomLineColor : UIColor = UIColor.orange
    var bottomLineHeight : CGFloat = 2
    /***************** 底部滚动条相关设置 ******************/
     
     
     /***************** 遮盖相关设置 ******************/
     // 是否显示遮盖
    var isShowCover : Bool = false
    var coverColor : UIColor = UIColor.gray
    var coverHeight : CGFloat = 30
    /// 文字&遮盖间隙
    var coverMargin : CGFloat = 5
    var coverRadius : CGFloat = 5
    /***************** 遮盖相关设置 ******************/
     
     
     
     /***************** UIPageControl相关设置 ******************/
    var pageControlHeight : CGFloat = 20
    var currentPageIndicatorTintColor: UIColor = UIColor.orange
    var pageIndicatorTintColor: UIColor = UIColor.black
    var pageControlBackgroundColor : UIColor = UIColor.gray
    /***************** UIPageControl相关设置 ******************/
     
     // 每一个item间的间距
    let titleMargin : CGFloat = 10
    
}
