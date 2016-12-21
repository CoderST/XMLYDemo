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
    func didSelectButtonAtIndex(stTabbar : STTabBar, index : Int)
}

class STTabBar: UIView {
    // MARK:- 变量
    weak var delegate : STTabbarDelegate?
    private var selectedButton : STButton?
    // MARK:- 懒加载
    private lazy var playButton : UIButton = {
        let playButton = UIButton(type: .Custom)
        playButton.setBackgroundImage(UIImage(named: "tabbar_np_play"), forState: .Normal)
        playButton.setBackgroundImage(UIImage(named: "tabbar_np_play"), forState: .Highlighted)
        
        if let currentBackgroundImage = playButton.currentBackgroundImage {
            playButton.bounds = CGRectMake(0, 0, currentBackgroundImage.size.width, currentBackgroundImage.size.height);
            playButton.bounds = CGRect(x: 0, y: 0, width: currentBackgroundImage.size.width, height: currentBackgroundImage.size.height)
        }
        
        playButton.addTarget(self, action: "playButtonAction:", forControlEvents: .TouchDown)
        
        return playButton
        
    }()
    private lazy var itemButtonArray : [STButton] = [STButton]()

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
        for (index,button) in itemButtonArray.enumerate(){
            button.tag = index
            var buttonX = CGFloat(index) * buttonWidth
            if index > 1 {
                buttonX = buttonX + buttonWidth
            }
            button.frame = CGRect(x: buttonX, y: buttonY, width: buttonWidth, height: buttonHeight)
            
            print(button.frame)
        }
    }
    
    
    func creatTabbarItem(item : UITabBarItem) {
        
        setupUI(item)
    }
    
    @objc private func playButtonAction(button : UIButton){
                print("playButtonAction")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    

}

extension STTabBar {
    
    private func setupUI(item : UITabBarItem) {
        guard let tabbarButton = STButton.creatButton(item) else { return }
        tabbarButton.addTarget(self, action: "tabbarButtonAction:", forControlEvents: .TouchDown)
        addSubview(tabbarButton)
        itemButtonArray.append(tabbarButton)
        
        if (itemButtonArray.count == 1) {
            selectedButton = tabbarButton
            tabbarButtonAction(tabbarButton)
        }

    }
    
    @objc private func tabbarButtonAction(button : STButton){
        delegate?.didSelectButtonAtIndex(self, index: button.tag)
        
        selectedButton!.selected = false;
        button.selected = true;
        selectedButton = button;
    }

}
