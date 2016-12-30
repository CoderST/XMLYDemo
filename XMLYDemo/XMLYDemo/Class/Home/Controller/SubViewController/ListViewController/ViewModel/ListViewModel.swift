//
//  ListViewModel.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/27.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class ListViewModel: NSObject {

    /// 焦点图
    lazy var focusModelArray : [FocusModel] = [FocusModel]()
    /// 主要数据
    lazy var listModelArray : [ListMainModel] = [ListMainModel]()
    func getlistData(_ finishCallback : @escaping ()->()) {
        let url = "http://mobile.ximalaya.com/mobile/discovery/v2/rankingList/group?channel=ios-b1&device=iPhone&includeActivity=true&includeSpecial=true&scale=2&version=5.4.57"
        NetWorkTools.shareInstance.requestData(.get, URLString: url) { (result) in
            guard let resultDic = result as? [String : AnyObject] else { return }
            
            if let dict = resultDic["focusImages"] as? [String : AnyObject] {
                if let dictArray = dict["list"] as? [[String : AnyObject]] {
                    for dict in dictArray{
                    self.focusModelArray.append(FocusModel(dict: dict))
                    }
                }
            }
            
            guard let dictArray = resultDic["datas"] as? [[String : AnyObject]] else { return }
            for dict in dictArray{
                
                self.listModelArray.append(ListMainModel(dict: dict))
            }
            finishCallback()
        }
    }
}
