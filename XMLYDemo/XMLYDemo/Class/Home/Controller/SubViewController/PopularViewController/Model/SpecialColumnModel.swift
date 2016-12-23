//
//  SpecialColumnModel.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/22.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class SpecialColumnModel: BaseModel {

    var title : String = ""
    var list : [SpecialColumnItem] = [SpecialColumnItem]()
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "list"{
            if let listArray = value as? [[String : AnyObject]]{
                for listDict in listArray {
                    list.append(SpecialColumnItem(dict: listDict))
                }
            }
        }else{
            
            super.setValue(value, forKey: key)
        }
    }

}
