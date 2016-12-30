//
//  ListFootReusableView.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/28.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class ListFootReusableView: UICollectionReusableView {
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
