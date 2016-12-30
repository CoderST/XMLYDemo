//
//  CategoryViewModel.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/27.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class CategoryViewModel: NSObject {

    /// 单个对象
    fileprivate lazy var categoryDatas : [CategoryModel] = [CategoryModel]()
    /// 多有组数据
    lazy var groups : [GroupCategory] = [GroupCategory]()
    
    func getCategoryData(_ finishedCallBack : @escaping ()->()) {
        let url = "http://mobile.ximalaya.com/mobile/discovery/v2/categories?channel=ios-b1&code=43_110000_1100&device=iPhone&picVersion=13&scale=2&version=5.4.57"
        NetWorkTools.shareInstance.requestData(.get, URLString: url) { (result) in
            
            guard let resultDic = result as? [String : AnyObject] else { return }
            guard let dictArray = resultDic["list"] as? [[String : AnyObject]] else { return }
            for dict in dictArray{
                
                self.categoryDatas.append(CategoryModel(dict: dict))
            }
            self.manageDatas()
            // 对数据进行重新分组
            finishedCallBack()
        }
    }
    
}

extension CategoryViewModel {
    
     fileprivate func manageDatas() {
        guard let firstModel = categoryDatas.first else { return }
        let groupCategoryOne = GroupCategory()
        groupCategoryOne.group.append(firstModel)
        groups.append(groupCategoryOne)
        /*
         
         var endItem = (indexPath.item + 1) * 8 - 1
         // 处理越界问题
         if endItem > groups!.count - 1{
         endItem = groups!.count - 1
         }
         let tempGroup = Array(groups![startItem ... endItem])
         cell.groups = tempGroup

         */
//        let tempcategoryDatasCount = categoryDatas.count - 1
        let count = (categoryDatas.count - 2) / 6 + 1   // -2的目的是排除了第一个元素(在上面已经添加到组中)
        let residueCount = (categoryDatas.count - 2) % 6
        for index in 0..<count{
            let groupCategoryIndex = GroupCategory()
            let startItem = index * 6 + 1
            let endItem = (startItem + 5) >= categoryDatas.count ? (startItem + residueCount) : (startItem + 5)
             let bbb =   Array(categoryDatas[startItem ... endItem])
            for model in bbb{
                groupCategoryIndex.group.append(model)
                
            }
             groups.append(groupCategoryIndex)
        }
    }
}
