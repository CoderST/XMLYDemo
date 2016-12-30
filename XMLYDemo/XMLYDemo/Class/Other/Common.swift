//
//  Common.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/21.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}


let iOS7 = Double(UIDevice.current.systemVersion) >= 7.0
/// 屏幕宽
let stScreenW = UIScreen.main.bounds.width
/// 屏幕高
let stScreenH = UIScreen.main.bounds.height

// 首页常量设置//
let searchButotnHeight : CGFloat = 30

// 推荐 -> 热门
/// 轮播图高度
let sRotationMapViewHeight : CGFloat = stScreenW * 4 / 8
/// 轮播图下面一排推荐的view
let sRecommendHeight : CGFloat = 80
// section Head尺寸
let sHeaderReferenceHeight : CGFloat = 50
// 列数
let sColumn : CGFloat = 3
// 列间距
let sMargin : CGFloat = 10
// 每一个item宽
let sItemWidth : CGFloat = (stScreenW - (sColumn + 1) * sMargin) / (sColumn)
// 猜你喜欢item高
let sGuessYouLikeItemHeight : CGFloat = sItemWidth * 5 / 4
// 普通item的高度
let sNormalItemHeight : CGFloat = sItemWidth * 3 / 2
// 精品听单高度
let sTingDanItemHeight : CGFloat = 80
