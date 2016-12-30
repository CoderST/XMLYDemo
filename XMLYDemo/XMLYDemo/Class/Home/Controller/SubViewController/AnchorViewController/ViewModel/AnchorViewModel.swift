//
//  AnchorViewModel.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/27.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class AnchorViewModel: NSObject {

    lazy var anchorSections : [AnchorSectionModel] = [AnchorSectionModel]()
    func getAnchorData(_ finishedCallback : @escaping ()->()) {
        let url = "http://mobile.ximalaya.com/mobile/discovery/v1/anchor/recommend?device=iPhone&version=5.4.57"
        NetWorkTools.shareInstance.requestData(.get, URLString: url) { (result) in
            guard let resultDict = result as? [String : AnyObject] else { return }
            guard let dictFamousArray = resultDict["famous"] as? [[String : AnyObject]] else { return }
            for dict in dictFamousArray{
                self.anchorSections.append(AnchorSectionModel(dict: dict))
            }
            
            guard let dictNormalArray = resultDict["normal"] as? [[String : AnyObject]] else { return }
            for dict in dictNormalArray{
                self.anchorSections.append(AnchorSectionModel(dict: dict))
            }

            finishedCallback()
            
        }
    }
}
