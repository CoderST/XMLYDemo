//
//  BaseViewController.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/21.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItems()

    }

}


extension BaseViewController {
    
    fileprivate func setupNavigationItems() {
        let downItem = UIBarButtonItem(image: UIImage(named: "top_download_n"), style: .plain, target: self, action: #selector(BaseViewController.downloadClick))
        let historyItem = UIBarButtonItem(image: UIImage(named: "top_history_n"), style: .plain, target: self, action: #selector(BaseViewController.historyClick))
        navigationItem.rightBarButtonItems = [downItem,historyItem]
    }
}

// MARK:- 事件监听
extension BaseViewController {
    @objc fileprivate func downloadClick() {
        print("downloadClick")
    }
    
    @objc fileprivate func historyClick() {
        print("historyClick")
    }


}
