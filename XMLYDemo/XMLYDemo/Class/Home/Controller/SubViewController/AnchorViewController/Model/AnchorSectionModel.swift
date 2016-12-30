//
//  AnchorMainModel.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/27.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class AnchorSectionModel: BaseModel {

    var id: Int64 = 0
    
    var title: String = ""
    
    var name: String = ""
    
    var displayStyle: Int = 0
    
    var list: [AnchorSectionList] = [AnchorSectionList]()
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "list" {
            guard let dictArray = value as? [[String : AnyObject]] else { return }
            for dict in dictArray{
                list.append(AnchorSectionList(dict: dict))
            }
        }else{
            
            super.setValue(value, forKey: key)
        }
    }
}
