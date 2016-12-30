//
//  ListMainModel.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/27.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class ListMainModel: BaseModel{

    var count : Int64 = 0
    var title : String = ""
    var list : [ListModel] = [ListModel]()
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "list"{
            guard let dictArray = value as? [[String : AnyObject]] else { return }
            for dict in dictArray{
                list.append(ListModel(dict: dict))
            }
        }else{
            
            super.setValue(value, forKey: key)
        }
    }
}
