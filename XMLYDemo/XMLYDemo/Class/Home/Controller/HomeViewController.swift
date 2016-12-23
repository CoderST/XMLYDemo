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
    private lazy var homeVM : HomeTitleVM = HomeTitleVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "首页"
        
        setupUI()
    }


}

extension HomeViewController {
    
    private func setupUI() {
        // 设置为false 不然STPageView的titleView的文本不显示(uiscrollow自动调整)
        automaticallyAdjustsScrollViewInsets = false
        
        // 设置搜索按钮
        setupSearchButton()
        
        // 设置主界面
        setupMainView()
    }
    
    private func setupSearchButton() {
        let searchBtn = STSearchButton(frame: CGRect(x: 0, y: 0, width: 200, height: searchButotnHeight))
        searchBtn.addTarget(self, action: "searchBtnAction", forControlEvents: .TouchUpInside)
        navigationItem.titleView = searchBtn
    }
    
    private func setupMainView() {
        
        let rect = CGRect(x: 0, y: 64, width: view.frame.size.width, height: view.frame.size.height - 64 - 49)
        
        let childsVC = [RecommendViewController(),PopularViewController(),CategoryViewController(),ListViewController(),AnchorViewController()]
        
        let style = STPageViewStyle()
        style.titleViewHeight = 44
        style.isShowScrollLine = true
        homeVM.getTitlesData {[weak self] in
            let titles = self!.homeVM.titles.map({$0.title})
            print(titles)
            let pageView = STPageView(frame: rect, titles: titles, childsVC: childsVC, parentVC: self!, style: style)
            
            self?.view.addSubview(pageView)
        }
    }
}

extension HomeViewController {
    
    @objc private func searchBtnAction() {
        
        print("searchBtnAction")
    }
}
