//
//  HotSubModel.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/26.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class  HotSubModel: BaseModel {

    /// model集合
    // 猜你喜欢
    // 小编推荐
    // 现场直播
    // 听北京
    // 精品听单
    // 推广
    var id : Int64 = 0
    var albumId : Int64 = 0
    var uid : Int64 = 0
    var title : String = ""
    var playsCounts : Int64 = 0
    var trackTitle : String = ""
    var albumCoverUrl290 :String = ""
    
    var nickname : String = ""
    
    var coverPath : String = ""
    
    var cover : String = ""
    
    var pic : String = ""
    var url : String = ""
    
    var subtitle : String = ""
    var footnote : String = ""
    
    
    var playCount : Int64 = 0
    var name : String = ""
    var shortDescription : String = ""
    var mydescription : String = ""
    
    var list : [HotSubModel] = [HotSubModel]()
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "list"{
            if let listArray = value as? [[String : AnyObject]]{
                for listDict in listArray {
                    list.append(HotSubModel(dict: listDict))
                }
            }
        }else{
            if key == "description"{
                if let des = value as? String{
                    mydescription = des
                }
            }
            super.setValue(value, forKey: key)
        }
    }
}
