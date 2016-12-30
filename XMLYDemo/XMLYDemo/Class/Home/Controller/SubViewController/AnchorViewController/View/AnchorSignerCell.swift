//
//  AnchorSignerCellCell.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/28.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit
private let iconImageHW : CGFloat = 50
class AnchorSignerCell: UICollectionViewCell {
    /// 头像
    fileprivate lazy var iconImageView : UIImageView = {
        
        let iconImageView = UIImageView()
//        iconImageView.layer.borderWidth = 1
//        iconImageView.layer.borderColor = UIColor.gray.cgColor
        iconImageView.layer.cornerRadius = iconImageHW * 0.5
        iconImageView.clipsToBounds = true
        return iconImageView
        
    }()
    fileprivate lazy var nameLabel : UILabel = {
        
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        nameLabel.textColor = UIColor.orange.withAlphaComponent(0.7)
        return nameLabel
        
    }()
    fileprivate lazy var musicLabel : UILabel = {
        
        let musicLabel = UILabel()
        musicLabel.font = UIFont.systemFont(ofSize: 12)
        return musicLabel
        
    }()
    // 足迹
    fileprivate lazy var tracksCountsButton : UIButton = {
        
        let tracksCountsButton = UIButton()
        tracksCountsButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        tracksCountsButton.setTitleColor(UIColor.gray, for: .normal)
        return tracksCountsButton
        
    }()
    
    /// 粉丝数
    fileprivate lazy var followersCountsButton : UIButton = {
        
        let followersCountsButton = UIButton()
        followersCountsButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
         followersCountsButton.setTitleColor(UIColor.gray, for: .normal)
        return followersCountsButton
        
    }()
    
    /// 关注
    fileprivate lazy var attentionButton : UIButton = {
        
        let attentionButton = UIButton()
        attentionButton.backgroundColor = UIColor.red
        attentionButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        attentionButton.setTitleColor(UIColor.orange, for: .normal)
        return attentionButton
        
    }()
    
    fileprivate lazy var lineView : UIView = {
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor(r: 230, g: 230, b: 230, alpha: 0.8)
        return lineView
        
    }()

    
    var singerModel : AnchorSectionList?{
        
        didSet{
            
            guard let singerModel = singerModel else { return }
            iconImageView.sd_setImage(with: URL(string: singerModel.largeLogo ), placeholderImage: UIImage(named: "find_radio_default"))
            nameLabel.text = singerModel.nickname
            musicLabel.text = singerModel.verifyTitle
            tracksCountsButton.setTitle("\(singerModel.tracksCounts)", for: .normal)
            followersCountsButton.setTitle(setupfollowNumber(singerModel.followersCounts), for: .normal)
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.addSubview(iconImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(musicLabel)
        contentView.addSubview(tracksCountsButton)
        contentView.addSubview(followersCountsButton)
        contentView.addSubview(attentionButton)
        contentView.addSubview(lineView)
        setupFrame()
    }
    
    fileprivate func setupFrame() {
        iconImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(iconImageHW)
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(10)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.top.equalTo(iconImageView).offset(-5)
        }
        
        musicLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.centerY.equalTo(contentView)
        }
        
        tracksCountsButton.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.bottom.equalTo(iconImageView.snp.bottom).offset(5)
        }
        
        followersCountsButton.snp.makeConstraints { (make) in
            make.left.equalTo(tracksCountsButton.snp.right).offset(10)
            make.top.equalTo(tracksCountsButton)
        }
        
        attentionButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).offset(-10)
        }
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(nameLabel)
            make.right.equalTo(contentView)
            make.height.equalTo(0.5)
            make.bottom.equalTo(contentView)
        }
    }
    
    fileprivate func setupfollowNumber(_ count : Int64) ->String{
        if count > 10000{
            let countString = String(format:"%.2f万",count / 10000)
            return countString
        }else{
            return "\(count)"
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
