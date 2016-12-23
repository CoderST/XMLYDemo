//
//  HomeVM.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/22.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class HomeTitleVM: NSObject {

    lazy var titles : [HomeTitleModel] = [HomeTitleModel]()
}

extension HomeTitleVM {
    
    func getTitlesData(finishedCallBack : ()->()){
        let url = "http://mobile.ximalaya.com/mobile/discovery/v2/tabs?device=iPhone&version=5.4.57"
        NetWorkTools.shareInstance.requestData(.GET, URLString: url) { (result) in
            guard let resultDic = result as? [String : AnyObject]else { return }
            guard let tagsDic = resultDic["tabs"] as? [String : AnyObject]else{ return }
            guard let listArray = tagsDic["list"] as? [[String : AnyObject]] else { return }
            for dict in listArray {
                self.titles.append(HomeTitleModel(dict: dict))
            }
            
            finishedCallBack()
        }
    }

}
