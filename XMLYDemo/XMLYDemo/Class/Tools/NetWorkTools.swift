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
    
    case get
    case post
}
class NetWorkTools {
    
    static let shareInstance : NetWorkTools = NetWorkTools()
    
    func requestData(_ type : MethodType, URLString : String, parameters:[String : Any]? = nil,finishCallBack : @escaping (_ result : Any) -> ()){
        // 确定请求类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else { return }
            
            
            finishCallBack(result: result)
        }
        
    }
    
}
