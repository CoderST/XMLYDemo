//
//  FocusImagesModel.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/22.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class FocusImagesModel: BaseModel {

    var title : String = ""
    var list : [FocusImagesItem] = [FocusImagesItem]()
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "list"{
            if let listArray = value as? [[String : AnyObject]]{
                for listDict in listArray {
                    list.append(FocusImagesItem(dict: listDict))
                }
            }
        }else{
            
            super.setValue(value, forKey: key)
        }
    }

}
