//
//  NetWorkTools.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/21.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit
import Alamofire
enum MethodType {
    
    case GET
    case POST
}
class NetWorkTools {

    static let shareInstance : NetWorkTools = NetWorkTools()
    
    func requestData(type : MethodType,URLString : String,parameters:[String : AnyObject]? = nil,finishCallBack : (result : AnyObject) -> ()){
        // 确定请求类型
        let method = type == .GET ? Method.GET : Method.POST
        
        // 发送网络请求
        Alamofire.request(method, URLString, parameters: parameters).responseJSON { (response) -> Void in
            // 守护结果
            guard let result = response.result.value else { return }
      
            
            finishCallBack(result: result)
            
        }
        
    }

}
