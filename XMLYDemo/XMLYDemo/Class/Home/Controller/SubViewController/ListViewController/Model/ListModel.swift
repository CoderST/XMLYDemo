//
//  ListModel.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/27.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class ListModel: BaseModel {

    var coverPath : String = ""
    var title : String = ""
    var subtitle : String = ""
    var firstKResults : [ListSubModel] = [ListSubModel]()
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "firstKResults"{
            guard let resultDicArray = value as? [[String : AnyObject]] else { return }
            for dict in resultDicArray{
                firstKResults.append(ListSubModel(dict: dict))
            }
        }else{
            
            super.setValue(value, forKey: key)
        }
    }
}
