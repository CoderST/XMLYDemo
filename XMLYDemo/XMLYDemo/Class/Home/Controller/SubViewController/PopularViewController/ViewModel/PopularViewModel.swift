//
//  PopularViewModel.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/23.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class PopularViewModel: NSObject {
    
    var indexTuiGuang : Int = 0
    
    /// 轮播图
    lazy var rotationMapModels :[HotSubModel] = [HotSubModel]()
    /// discoveryColumns 轮播图下面一排东东
    lazy var discoveryColumnsSubItem :[HotSubModel] = [HotSubModel]()
    /// 下面展示多有的东西
    lazy var popularModels : [HotMainModel] = [HotMainModel]()
    /// 小编推荐,精品听单    猜你喜欢,听北京  推广    现场直播
    lazy var xiaoBianTuiJijanModels : [HotMainModel] = [HotMainModel]()
    /// 精品听单
    lazy var jingPingTingDanModels : [HotMainModel] = [HotMainModel]()
    /// 猜你喜欢
    lazy var caiNiXiHuanModels : [HotMainModel] = [HotMainModel]()
    /// 听北京
    lazy var tingBeiJingnModels : [HotMainModel] = [HotMainModel]()
    /// 推广
    lazy var tuiGuangModels : [HotMainModel] = [HotMainModel]()
    /// 现场直播
    lazy var xianChagnZhiBoModels : [HotMainModel] = [HotMainModel]()
}

// 轮播图,小编推荐,精品听单
extension PopularViewModel {
    
    func getData(_ finishCallBack : @escaping ()->()){
        let group = DispatchGroup()
        
        let url = "http://mobile.ximalaya.com/mobile/discovery/v4/recommends?channel=ios-b1&device=iPhone&includeActivity=true&includeSpecial=true&scale=2&version=5.4.57"
        group.enter()
        NetWorkTools.shareInstance.requestData(.get, URLString: url) { (result) in
            guard let resultDic = result as? [String : AnyObject] else { return }
            // 轮播
            if let focusImagesDic = resultDic["focusImages"] as? [String : AnyObject]{
                if let listDict = focusImagesDic["list"] as? [[String : AnyObject]]{
                    for dict in listDict{
                        let demo = HotSubModel(dict: dict)
                        self.rotationMapModels.append(demo)
                    }
                }
                
                
            }
            // 小编推荐
            if let editorRecommendDic = resultDic["editorRecommendAlbums"] as? [String : AnyObject]{
                let demo = HotMainModel(dict: editorRecommendDic)
                self.xiaoBianTuiJijanModels.append(demo)
            }
            // 精品听单
            if let specialColumnDic = resultDic["specialColumn"] as? [String : AnyObject]{
                let demo = HotMainModel(dict: specialColumnDic)
                self.jingPingTingDanModels.append(demo)
            }
            
            group.leave()
        }
        
        // 发现,猜你喜欢,推荐,热门数据
        let urls = "http://mobile.ximalaya.com/mobile/discovery/v2/recommend/hotAndGuess?code=43_110000_1100&device=iPhone&version=5.4.57"
        group.enter()
        NetWorkTools.shareInstance.requestData(.get, URLString: urls) { (result) in
            guard let resultDic = result as? [String : AnyObject] else { return }
            
            if let discoveryColumnsDic = resultDic["discoveryColumns"] as? [String : AnyObject]{
                
                if let listDict = discoveryColumnsDic["list"] as? [[String : AnyObject]]{
                    for dict in listDict{
                        let demo = HotSubModel(dict: dict)
                        self.discoveryColumnsSubItem.append(demo)
                    }
                }
            }
            // 猜你喜欢
            if let guessDic = resultDic["guess"] as? [String : AnyObject]{
                let demo = HotMainModel(dict: guessDic)
                self.caiNiXiHuanModels.append(demo)
            }
            // 听北京
            if let cityColumnDic = resultDic["cityColumn"] as? [String : AnyObject]{
                let demo = HotMainModel(dict: cityColumnDic)
                self.tingBeiJingnModels.append(demo)
            }
            // 热门推荐
            if let hotRecommendsDic = resultDic["hotRecommends"] as? [String : AnyObject]{
                if let tempDicArray = hotRecommendsDic["list"] as? [[String : AnyObject]] {
                    for dict in tempDicArray{
                        let demo = HotMainModel(dict: dict)
                        self.popularModels.append(demo)
                        
                    }
                }
            }
            group.leave()
        }
        
        /// 直播
        let urlLive = "http://live.ximalaya.com/live-activity-web/v3/activity/recommend"
        group.enter()
        NetWorkTools.shareInstance.requestData(.get, URLString: urlLive) { (result) in
            guard let resultDic = result as? [String : AnyObject] else { return }
            self.xianChagnZhiBoModels.append(HotMainModel(dict: resultDic))
            group.leave()
        }
        
        // 推广
        let urlts = "http://adse.ximalaya.com/ting/feed?appid=0&device=iPhone&name=find_native&network=WIFI&operator=3&scale=2&version=5.4.57"
        group.enter()
        NetWorkTools.shareInstance.requestData(.get, URLString: urlts, finishCallBack: { (result) in
            guard let resultDic = result as? [String : AnyObject] else { return }
            let demo = HotMainModel(dict: resultDic)
            self.tuiGuangModels.append(demo)
            group.leave()
        })
        
        
        // 对数据进行排序
        group.notify(queue: DispatchQueue.main) { () -> Void in
            // 猜你喜欢
            self.insertData(0, object: self.caiNiXiHuanModels,title: "猜你喜欢")
            // 小编推荐
            self.insertData(2, object: self.xiaoBianTuiJijanModels,title: "小编推荐")
            // 现场直播(自定义collectionView展示数据)
            self.insertData(3, object: self.xianChagnZhiBoModels,title: "现场直播")
            // 听北京
            self.insertData(4, object: self.tingBeiJingnModels,title: "听北京")
            // 精品听单
            self.insertData(5, object: self.jingPingTingDanModels,title: "精品听单")
            // 推广
            
            if let tuiguangCount = self.tuiGuangModels.first?.list.count{
                for index in 0..<tuiguangCount{
                    self.insertData((index + 1) * 6, object: [HotMainModel](),title: "推广")
                }
            }
            
            finishCallBack()
        }
        
        
    }
    
    fileprivate func insertData(_ index : Int, object : [HotMainModel], title : String) {
        // 推推广和直播单独做处理  推广每隔5个添加一个   现场直播只用一个cell展示
        if title == "推广"{
            let tuiguangSub = tuiGuangModels.first!.list[indexTuiGuang]
            let tempModel = HotMainModel()
            tempModel.tuiGuangIndex = index
            tempModel.title = title
            tempModel.list.append(tuiguangSub)
            indexTuiGuang += 1
            self.popularModels.insert(tempModel, at: index)
            
        }else if title == "现场直播"{  // 此处只用于展示界面  真是使用数据用xianChagnZhiBoModels里的真是数据
            let tempModel = HotMainModel()
            tempModel.title = title
            let subModel = HotSubModel()
            tempModel.list.append(subModel)
            self.popularModels.insert(tempModel, at: index)
            
        }else{
            let tempModel = object.first
            tempModel!.title = title
            
            self.popularModels.insert(object.first!, at: index)
            
        }
    }
}

