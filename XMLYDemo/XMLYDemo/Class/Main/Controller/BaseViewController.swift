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
    
    private func setupNavigationItems() {
        let downItem = UIBarButtonItem(image: UIImage(named: "top_download_n"), style: .Plain, target: self, action: "downloadClick")
        let historyItem = UIBarButtonItem(image: UIImage(named: "top_history_n"), style: .Plain, target: self, action: "historyClick")
        navigationItem.rightBarButtonItems = [downItem,historyItem]
    }
}

// MARK:- 事件监听
extension BaseViewController {
    @objc private func downloadClick() {
        print("downloadClick")
    }
    
    @objc private func historyClick() {
        print("historyClick")
    }


}