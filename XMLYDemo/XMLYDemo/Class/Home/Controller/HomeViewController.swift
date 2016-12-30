//
//  HomeViewController.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/21.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    // MARK:- 懒加载
    fileprivate lazy var homeVM : HomeTitleVM = HomeTitleVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
/// 注意:在没有升级前下面这样写没有问题,升级后发现直接这样写会在tabBar出现一层(_UIBarBackground)frame = (0 0; 375 49),遮挡了tabBar的点击
//        title = "首页"
        navigationItem.title = "首页"
        
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 隐藏底部线
        navigationController?.navigationBar.hideBottomHairline()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 显示底部线
        navigationController?.navigationBar.showBottomHairline()
    }
    
}

extension HomeViewController {
    
    fileprivate func setupUI() {
        // 设置为false 不然STPageView的titleView的文本不显示(uiscrollow自动调整)
        automaticallyAdjustsScrollViewInsets = false
        
        // 设置搜索按钮
        setupSearchButton()
        
        // 设置主界面
        setupMainView()
    }
    
    fileprivate func setupSearchButton() {
        let searchBtn = STSearchButton(frame: CGRect(x: 0, y: 0, width: 200, height: searchButotnHeight))
        searchBtn.addTarget(self, action: #selector(HomeViewController.searchBtnAction), for: .touchUpInside)
        navigationItem.titleView = searchBtn
    }
    
    fileprivate func setupMainView() {
        
        let rect = CGRect(x: 0, y: 64, width: view.frame.size.width, height: view.frame.size.height - 64 - 49)
        
        let childsVC = [RecommendViewController(),PopularViewController(),CategoryViewController(),ListViewController(),AnchorViewController()]
        
        let style = STPageViewStyle()
        style.titleViewHeight = 44
        style.isShowScrollLine = true
        style.titleViewBackgroundColor = UIColor(r: 237, g: 237, b: 237)
        homeVM.getTitlesData {[weak self] in
            let titles = self!.homeVM.titles.map({$0.title})
            print(titles)
            let pageView = STPageView(frame: rect, titles: titles, childsVC: childsVC, parentVC: self!, style: style)
            
            self?.view.addSubview(pageView)
        }
    }
}

extension HomeViewController {
    
    @objc fileprivate func searchBtnAction() {
        
        print("searchBtnAction")
    }
}
