//
//  Common.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/21.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

let iOS7 = Double(UIDevice.currentDevice().systemVersion) >= 7.0
/// 屏幕宽
let stScreenW = UIScreen.mainScreen().bounds.width
/// 屏幕高
let stScreenH = UIScreen.mainScreen().bounds.height

// 首页常量设置//
let searchButotnHeight : CGFloat = 30

// 推荐 -> 热门
/// 轮播图高度
let sRotationMapViewHeight : CGFloat = stScreenW * 3 / 8
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