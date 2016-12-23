//
//  RecommendVM.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/21.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class PopularVM: NSObject {
    // 发现,猜你喜欢,推荐,热门数据
    var discoverModel : DiscoveryColumnsModel?
    var guessModel : GuessModel?
    var cityColumnModel : CityColumnModel?
    var hotRecommendsModel : HotRecommendsModel?
    
    // 轮播图,小编推荐,精品听单
    var focusImagesModel : FocusImagesModel?
    var editorRecommendAlbumsModel : EditorRecommendAlbumsModel?
    var specialColumnModel : SpecialColumnModel?
}

// 发现,猜你喜欢,推荐,热门数据
extension PopularVM {
    func getMainDatas(finishedCallBack : ()->()){
        let url = "http://mobile.ximalaya.com/mobile/discovery/v2/recommend/hotAndGuess?code=43_110000_1100&device=iPhone&version=5.4.57"
        NetWorkTools.shareInstance.requestData(.GET, URLString: url) { (result) in
            guard let resultDic = result as? [String : AnyObject] else { return }
            
            if let discoveryColumnsDic = resultDic["discoveryColumns"] as? [String : AnyObject]{
                self.discoverModel = DiscoveryColumnsModel(dict: discoveryColumnsDic)
            }
            
            if let guessDic = resultDic["guess"] as? [String : AnyObject]{
                self.guessModel = GuessModel(dict: guessDic)
            }
            
            if let cityColumnDic = resultDic["cityColumn"] as? [String : AnyObject]{
                self.cityColumnModel = CityColumnModel(dict: cityColumnDic)
            }
            
            if let hotRecommendsDic = resultDic["hotRecommends"] as? [String : AnyObject]{
                self.hotRecommendsModel = HotRecommendsModel(dict: hotRecommendsDic)
            }
            
            finishedCallBack()
        }
    }

}

// 轮播图,小编推荐,精品听单
extension PopularVM {
    func getRecommendsIncludeActivityData(finishedCallBack : ()->()) {
        let url = "http://mobile.ximalaya.com/mobile/discovery/v4/recommends?channel=ios-b1&device=iPhone&includeActivity=true&includeSpecial=true&scale=2&version=5.4.57"
        NetWorkTools.shareInstance.requestData(.GET, URLString: url) { (result) in
            guard let resultDic = result as? [String : AnyObject] else { return }
            // 轮播
            if let focusImagesDic = resultDic["focusImages"] as? [String : AnyObject]{
                self.focusImagesModel = FocusImagesModel(dict: focusImagesDic)
            }
            // 小编推荐
            if let editorRecommendDic = resultDic["editorRecommendAlbums"] as? [String : AnyObject]{
                self.editorRecommendAlbumsModel = EditorRecommendAlbumsModel(dict: editorRecommendDic)
            }
            // 精品听单
            if let specialColumnDic = resultDic["specialColumn"] as? [String : AnyObject]{
                self.specialColumnModel = SpecialColumnModel(dict: specialColumnDic)
            }
          
            finishedCallBack()
        }
    }

}
