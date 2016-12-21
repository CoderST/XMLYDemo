//
//  STPageView.swift
//  STPageView
//
//  Created by xiudou on 2016/12/5.
//  Copyright © 2016年 CoderST. All rights reserved.
//  主要的View

import UIKit

class STPageView: UIView {

    // MARK:- 定义属性
    private var titles : [String]
    private var childsVC : [UIViewController]
    private var parentVC : UIViewController
    private var style : STPageViewStyle
    private var titleView : STTitlesView!
    
    
    // MARK:- 自定义构造函数
    init(frame: CGRect, titles : [String], childsVC : [UIViewController], parentVC : UIViewController, style : STPageViewStyle) {
        // 初始化前一定要给属性赋值,不然会报super dont init 错误
        self.titles = titles
        self.parentVC = parentVC
        self.childsVC = childsVC
        self.style = style
        super.init(frame: frame)
        
        stupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension STPageView {
    
    private func stupUI(){
        
        stupTitleView()
        setupContentView()
        
    }
    
    private func stupTitleView(){
        let titleviewF = CGRect(x: 0, y: 0, width: self.frame.width, height: style.titleViewHeight)
        titleView = STTitlesView(frame: titleviewF, titles: self.titles, style: self.style)
        titleView.backgroundColor = UIColor.randomColor()
         addSubview(titleView)

    }
    
    private func setupContentView(){
        let contentViewF = CGRect(x: 0, y: style.titleViewHeight, width: self.frame.width, height: self.frame.height - style.titleViewHeight)
        let contentView = STContentView(frame: contentViewF, childsVC: self.childsVC, parentVC: self.parentVC)
        addSubview(contentView)
        
        titleView.delegate = contentView
        contentView.delegate = titleView
    }
}
