//
//  HotMainModel.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/26.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class HotMainModel: BaseModel {

    var title : String = ""
    var list : [HotSubModel] = [HotSubModel]()
    var tuiGuangIndex : Int = 0
    var width : CGFloat = 0
    var height : CGFloat = 0
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "list" || key == "data"{
            if let listArray = value as? [[String : AnyObject]]{
                for listDict in listArray {
                    list.append(HotSubModel(dict: listDict))
                }
            }
        }else{
            super.setValue(value, forKey: key)
        }
    }

    
    
   
}
