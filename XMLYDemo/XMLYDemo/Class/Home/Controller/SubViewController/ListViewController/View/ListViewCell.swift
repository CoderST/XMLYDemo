//
//  ListViewCell.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/27.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit

class ListViewCell: UICollectionViewCell {
    fileprivate lazy var iconImageView : UIImageView = {
        
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.clipsToBounds = true
        return iconImageView
        
    }()
    
    fileprivate lazy var titleLabel : UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.numberOfLines = 2
        return titleLabel
        
    }()

    fileprivate lazy var firstLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        return titleLabel
    }()
    
    fileprivate lazy var twoLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        return titleLabel
    }()
    
    fileprivate lazy var lineView : UIView = {
       let lineView = UIView()
        lineView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        return lineView
    }()

    var listModel : ListModel?{
        didSet{
            guard let listModel = listModel else { return }
            iconImageView.sd_setImage( with: URL(string: listModel.coverPath ), placeholderImage: UIImage(named: "placeholder_image"))
            titleLabel.text = listModel.title
            
            firstLabel.text = listModel.firstKResults.first?.title
            if  listModel.firstKResults.count > 1 {
                
                twoLabel.text = listModel.firstKResults[1].title
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.white
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(firstLabel)
        contentView.addSubview(twoLabel)
        contentView.addSubview(lineView)
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView).offset(-10)
            make.width.equalTo(contentView.bounds.height - 20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.right.equalTo(contentView.snp.right).offset(-10)
            make.top.equalTo(iconImageView)
        }
        
        firstLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        twoLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.right.equalTo(titleLabel)
            make.top.equalTo(firstLabel.snp.bottom).offset(5)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.right.bottom.equalTo(contentView)
            make.height.equalTo(0.5)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
