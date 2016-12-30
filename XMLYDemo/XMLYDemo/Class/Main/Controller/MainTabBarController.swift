//
//  MainTabBarController.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/21.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK:- 懒加载
    fileprivate lazy var tabbar : STTabBar = {[weak self] in
        let tabbar = STTabBar()
        tabbar.delegate = self
        tabbar.frame = self!.tabBar.bounds
        return tabbar

    }()
    
    // MARK:- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1 自定义tabBar
        setupTabBar()
        // 2 添加子控制器
        setupAddChildViewController()
        // 3 去除tabBar上的线
        removeImageViewLine()
    }
    
    /// 去除系统的item
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for subView in tabBar.subviews{
            guard subView is UIControl else { continue }
            subView.removeFromSuperview()
        }
    }
    
    
}

extension MainTabBarController {
    
    fileprivate func setupTabBar() {
        tabBar.addSubview(tabbar)
    }
    
    fileprivate func setupAddChildViewController() {
        addChildVc(HomeViewController(), title: "", normalImageName: "tabbar_icon_homepage_normal", selectedImageName: "tabbar_icon_homepage_pressed")
        addChildVc(SubscriptionViewController(), title: "", normalImageName: "tabbar_icon_Rss_normal", selectedImageName: "tabbar_icon_Rss_pressed")
        addChildVc(FindViewController(), title: "", normalImageName: "tabbar_icon_find_normal", selectedImageName: "tabbar_icon_find_pressed")
        addChildVc(MeViewController(), title: "", normalImageName: "tabbar_icon_my_normal", selectedImageName: "tabbar_icon_my_pressed")

    }
    
    fileprivate func removeImageViewLine() {
        
        let rect = CGRect(x: 0, y: 0, width: stScreenW, height: stScreenH);
        
        UIGraphicsBeginImageContext(rect.size);
        
        let context = UIGraphicsGetCurrentContext();
        
        context?.setFillColor(UIColor.clear.cgColor);
        
        context?.fill(rect);
        
        let img = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        tabBar.backgroundImage = img
        tabBar.shadowImage = img

    }
    
    // 子控制器实现
    fileprivate func addChildVc(_ childVc : UIViewController, title : String, normalImageName : String, selectedImageName : String){
        // 标题
        childVc.title = title
        // 图片
        childVc.tabBarItem.image = UIImage(named: normalImageName)
        guard let selectedImage = UIImage(named: selectedImageName) else { return }
        if iOS7{
            childVc.tabBarItem.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        }else{
            childVc.tabBarItem.selectedImage = selectedImage
        }
        
        let mainNav = MainNavigationController(rootViewController: childVc)
        
        addChildViewController(mainNav)
        
        tabbar.creatTabbarItem(childVc.tabBarItem)
    }
}

extension MainTabBarController : STTabbarDelegate {
    
    func didSelectButtonAtIndex(_ stTabbar: STTabBar, index: Int) {
        selectedIndex = index
    }
}

