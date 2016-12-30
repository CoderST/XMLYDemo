//
//  STTarBar.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/21.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit
/// 定义协议
protocol STTabbarDelegate : class{
    func didSelectButtonAtIndex(_ stTabbar : STTabBar, index : Int)
}

class STTabBar: UIView {
    // MARK:- 变量
    weak var delegate : STTabbarDelegate?
    fileprivate var selectedButton : STButton?
    // MARK:- 懒加载
    fileprivate lazy var playButton : UIButton = {
        let playButton = UIButton(type: .custom)
        playButton.setBackgroundImage(UIImage(named: "tabbar_np_play"), for: UIControlState())
        playButton.setBackgroundImage(UIImage(named: "tabbar_np_play"), for: .highlighted)
        
        if let currentBackgroundImage = playButton.currentBackgroundImage {
            playButton.bounds = CGRect(x: 0, y: 0, width: currentBackgroundImage.size.width, height: currentBackgroundImage.size.height);
            playButton.bounds = CGRect(x: 0, y: 0, width: currentBackgroundImage.size.width, height: currentBackgroundImage.size.height)
        }
        
        playButton.addTarget(self, action: #selector(STTabBar.playButtonAction(_:)), for: .touchDown)
        
        return playButton
        
    }()
    fileprivate lazy var itemButtonArray : [STButton] = [STButton]()

    // 生命周期
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if (!iOS7) {
            if let backImage = UIImage(named: "tabbar_background"){
                
                backgroundColor = UIColor(patternImage: backImage)
            }
            
            
        }
        backgroundColor = UIColor(patternImage: UIImage(named: "tabbar_bg")!)
        addSubview(playButton)
        
    }
    
    // 布局子空间
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = frame.size.width
        let height = frame.size.height
        
        playButton.center = CGPoint(x: width * 0.5, y: height * 0.5)
        
        let buttonWidth = width / CGFloat(subviews.count)
        let buttonHeight = height
        let buttonY : CGFloat = 0
        for (index,button) in itemButtonArray.enumerated(){
            button.tag = index
            var buttonX = CGFloat(index) * buttonWidth
            if index > 1 {
                buttonX = buttonX + buttonWidth
            }
            button.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
            
        }
    }
    
    
    func creatTabbarItem(_ item : UITabBarItem) {
        
        setupUI(item)
    }
    
    @objc fileprivate func playButtonAction(_ button : UIButton){
                print("playButtonAction")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    

}

extension STTabBar {
    
    fileprivate func setupUI(_ item : UITabBarItem) {
        guard let tabbarButton = STButton.creatButton(item) else { return }
        tabbarButton.addTarget(self, action: #selector(STTabBar.tabbarButtonAction(_:)), for: .touchDown)
        addSubview(tabbarButton)
        itemButtonArray.append(tabbarButton)
        
        if (itemButtonArray.count == 1) {
            selectedButton = tabbarButton
            tabbarButtonAction(tabbarButton)
        }

    }
    
    @objc fileprivate func tabbarButtonAction(_ button : STButton){
        delegate?.didSelectButtonAtIndex(self, index: button.tag)
        
        selectedButton!.isSelected = false;
        button.isSelected = true;
        selectedButton = button;
    }

}
