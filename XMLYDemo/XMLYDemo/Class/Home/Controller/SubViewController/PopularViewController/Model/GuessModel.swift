//
//  GuessModel.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/22.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class GuessModel: BaseModel {

    var title : String = ""
    var list : [GuessItem] = [GuessItem]()
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "list"{
            if let listArray = value as? [[String : AnyObject]]{
                for listDict in listArray {
                    list.append(GuessItem(dict: listDict))
                }
            }
        }else{
            super.setValue(value, forKey: key)
        }
    }
    
}
