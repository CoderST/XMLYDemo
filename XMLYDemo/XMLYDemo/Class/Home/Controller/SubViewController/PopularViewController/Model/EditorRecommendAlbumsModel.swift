//
//  EditorRecommendAlbumsModel.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/22.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class EditorRecommendAlbumsModel: BaseModel {

    
    var title : String = ""
    var list : [EditorRecommendAlbumsItem] = [EditorRecommendAlbumsItem]()
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "list"{
            if let listArray = value as? [[String : AnyObject]]{
                for listDict in listArray {
                    list.append(EditorRecommendAlbumsItem(dict: listDict))
                }
            }
        }else{
            
            super.setValue(value, forKey: key)
        }
    }

}
