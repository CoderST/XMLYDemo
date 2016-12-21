//
//  STTitlesView.swift
//  STPageView
//
//  Created by xiudou on 2016/12/5.
//  Copyright © 2016年 CoderST. All rights reserved.
//  顶部的titleView

import UIKit
protocol STTitlesViewDelegate : class{
    func stTitlesView(stTitlesView : STTitlesView, toIndex : Int)
}
class STTitlesView: UIView {
    // 手势数组
    private var tapGestArray : [UITapGestureRecognizer] = [UITapGestureRecognizer]()
    // MARK:- 变量
    var currentIndex : Int = 0
    
    // MARK:- 定义属性
    var titles : [String]
    var style : STPageViewStyle
    
    weak var delegate : STTitlesViewDelegate?
    
    // MARK:- 懒加载
    private lazy var labelArray : [UILabel] = [UILabel]()
    
    /// UIScrollView
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        return  scrollView
    }()
    
    /// 底部滚动条
    private lazy var bottomLine : UIView = {
        let bottomLine = UIView()
        bottomLine.backgroundColor = self.style.bottomLineColor
//        bottomLine.frame.size.height = self.style.scrollLineHeight
//        bottomLine.frame.origin.y = self.bounds.height - self.style.scrollLineHeight
        return bottomLine
        
    }()
    /// 遮盖
    private lazy var coverView : UIView = {
        let coverView = UIView()
        coverView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.7)
        return coverView
    }()
    
    // MARK: 计算属性
    private lazy var normalColorRGB : (r : CGFloat, g : CGFloat, b : CGFloat) = self.getRGBWithColor(self.style.normalColor)
    
    private lazy var selectedColorRGB : (r : CGFloat, g : CGFloat, b : CGFloat) = self.getRGBWithColor(self.style.selectColor)

    
    // MARK:- 自定义构造函数
    init(frame: CGRect, titles : [String] , style : STPageViewStyle) {
        self.titles = titles
        self.style = style
        super.init(frame: frame)
        
        setupUI()
        
        // 判断本地是否有用户点击menuType记录
        guard let cacheIndex = STNSUserDefaults.objectForKey(HOMETYPE) as? Int else { return }
        enumerateIndex(cacheIndex)
        
        // 监听选中menuType的事件
        STNSNotificationCenter.addObserver(self, selector: "didSelectedMenuTypeClick:", name: DIDSELECTED_MENUM_TYPE, object: nil)
        
        
    }
    
    
    func didSelectedMenuTypeClick(notic : NSNotification){
        guard let index = notic.object as? Int else { return }
        enumerateIndex(index)
    }
    
    func enumerateIndex(index : Int){
        for (_,label) in labelArray.enumerate(){
            if label.tag == index{
                let tap = tapGestArray[label.tag]
                tapGestureClick(tap)
                break
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

// MARK:- 设置UI
extension STTitlesView {
    private func setupUI(){
        
        // 1 添加ScrollView
        addSubview(scrollView)
        
        // 2 设置TitleLabel
        setupTitleLabel()
        
        // 3 设置TitleLabels位置
        setupTitleLabelsPosition()
        
        // 4 添加底部滚动条
        if style.isShowScrollLine{
            setupBottomLine()
        }
        
        // 5 添加底部遮盖
        if style.isShowCover{
            setupCoverView()
        }
        
    }
    
    // 配置label
    private func setupTitleLabel(){
        
        for (index,title) in titles.enumerate(){
            let label = UILabel()
            label.backgroundColor = style.titleViewBackgroundColor
            label.userInteractionEnabled = true
            label.text = title
            label.tag = index
            label.text = titles[index]
            label.textAlignment = .Center
            label.textColor = index == 0 ? style.selectColor : style.normalColor
            label.font = UIFont.systemFontOfSize(style.fontSize)
            scrollView.addSubview(label)
            labelArray.append(label)
            
            // 添加手势
            let tapGesture = UITapGestureRecognizer(target: self, action: "tapGestureClick:")
            label.addGestureRecognizer(tapGesture)
            tapGestArray.append(tapGesture)
            
        }
    }
    // 配置Position
    private func setupTitleLabelsPosition(){
        
        var titleX: CGFloat = 0.0
        var titleW: CGFloat = 0.0
        let titleY: CGFloat = 0.0
        let titleH : CGFloat = frame.height
        let count = titles.count
        
        for (index, label) in labelArray.enumerate() {
            if style.isScrollEnable {
                let rect = (titles[index] as NSString).boundingRectWithSize(CGSize(width: CGFloat(MAXFLOAT), height: 0), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName : label.font], context: nil)
                    titleW = rect.width
                if index == 0 {
                    titleX = style.titleMargin * 0.5
                } else {
                    let preLabel = labelArray[index - 1]
                    titleX = preLabel.frame.maxX + style.titleMargin
                }
                
            } else {
                titleW = frame.width / CGFloat(count)
                titleX = titleW * CGFloat(index)
            }
            
            label.frame = CGRect(x: titleX, y: titleY, width: titleW, height: titleH)
            
            // 放大的代码
            if index == 0 {
                let scale = style.isNeedScale ? style.scaleRange : 1.0
                label.transform = CGAffineTransformMakeScale(scale, scale)
            }

    }
        scrollView.contentSize = style.isScrollEnable ? CGSize(width: labelArray.last!.frame.maxX + style.titleMargin * 0.5, height: 0) : CGSize.zero
    
}
    // 设置滚动条
    private func setupBottomLine(){
        scrollView.addSubview(bottomLine)
        bottomLine.frame = labelArray.first!.frame
        bottomLine.frame.size.height = style.bottomLineHeight
        bottomLine.frame.origin.y = bounds.height - style.bottomLineHeight
    }
    
    // 设置遮盖
    private func setupCoverView() {
        scrollView.insertSubview(coverView, atIndex: 0)
        let firstLabel = labelArray[0]
        var coverW = firstLabel.frame.width
        let coverH = style.coverHeight
        var coverX = firstLabel.frame.origin.x
        let coverY = (bounds.height - coverH) * 0.5
        
        if style.isScrollEnable {
            coverX -= style.coverMargin
            coverW += style.coverMargin * 2
        }
        coverView.frame = CGRect(x: coverX, y: coverY, width: coverW, height: coverH)
        
        coverView.layer.cornerRadius = style.coverRadius
        coverView.layer.masksToBounds = true
    }

}

// MARK:- 获取RGB的值
extension STTitlesView {
    private func getRGBWithColor(color : UIColor) -> (CGFloat, CGFloat, CGFloat) {
        let components = CGColorGetComponents(color.CGColor)

        if components[0] >= 0 && components[1] >= 0 && components[2] >= 0{
            
            return (components[0] * 255, components[1] * 255, components[2] * 255)
        }else{
            fatalError("请使用RGB方式给Title赋值颜色")
        }
    }
}


// MARK:- titleLabel点击事件
extension STTitlesView {
    
    func tapGestureClick(tapGesture : UITapGestureRecognizer){
        guard let targetLabel = tapGesture.view as? UILabel else { return }
        // 1 调整label的状态(结束选中的颜色,以及滚动到屏幕中部)
        adjustLabel(targetLabel.tag)
        
        // 2 判断是否显示底部滚动条
        if style.isShowScrollLine{
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.bottomLine.frame.origin.x = targetLabel.frame.origin.x
                self.bottomLine.frame.size.width = targetLabel.frame.width
            })
        }
        
        // 3 判断是否显示遮盖
        if style.isShowCover{
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.coverView.frame.origin.x = targetLabel.frame.origin.x
                self.coverView.frame.size.width = targetLabel.frame.width
            })
        }
        
        delegate?.stTitlesView(self, toIndex: currentIndex)
    }
    
    func adjustLabel(targetIndex : Int){
        if currentIndex == targetIndex {return}
        // 取出label
        let fromLabel = labelArray[currentIndex]
        let targetLabel = labelArray[targetIndex]
        
        // 切换颜色
        fromLabel.textColor = style.normalColor
        targetLabel.textColor = style.selectColor
        
        // 调整比例
        if style.isNeedScale {
            fromLabel.transform = CGAffineTransformIdentity
            targetLabel.transform = CGAffineTransformMakeScale(style.scaleRange,style.scaleRange)
        }

        
        //记录当前下标值
        currentIndex = targetIndex
        
        // 设置scrollView contentOffSet.x位置
        if style.isScrollEnable{
            var offsetX = targetLabel.center.x - scrollView.bounds.width * 0.5
            if offsetX < 0 {
                offsetX = 0
            }
            if offsetX > (scrollView.contentSize.width - scrollView.bounds.width) {
                offsetX = scrollView.contentSize.width - scrollView.bounds.width
            }
            // 设置label居中显示
            scrollView.setContentOffset(CGPoint(x: offsetX, y : 0), animated: true)
        }
        
        
    }
}

// MARK:- STContentViewDelegate
extension STTitlesView : STContentViewDelegate {
    
    func stContentView(stContentView: STContentView, targetIndex: Int) {
        
        adjustLabel(targetIndex)
    }
    
    func stContentView(stContentView: STContentView,currentIndex : Int, targetIndex: Int, process: CGFloat) {
        // 1 取出label
        let sourceLabel = labelArray[currentIndex]
        let targetLabel = labelArray[targetIndex]
        
        // 2.颜色渐变
        let deltaRGB = UIColor.getRGBDelta(style.selectColor, seccondColor: style.normalColor)
        let selectRGB = style.selectColor.getRGB()
        let normalRGB = style.normalColor.getRGB()
        
        targetLabel.textColor = UIColor(r: normalRGB.0 + deltaRGB.0 * process, g: normalRGB.1 + deltaRGB.1 * process, b: normalRGB.2 + deltaRGB.2 * process)
        sourceLabel.textColor = UIColor(r: selectRGB.0 - deltaRGB.0 * process, g: selectRGB.1 - deltaRGB.1 * process, b: selectRGB.2 - deltaRGB.2 * process)
        
        // 3.bottomLine渐变过程
        if style.isShowScrollLine {
            let deltaX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
            let deltaW = targetLabel.frame.width - sourceLabel.frame.width
            bottomLine.frame.origin.x = sourceLabel.frame.origin.x + deltaX * process
            bottomLine.frame.size.width = sourceLabel.frame.width + deltaW * process
        }
        
        // 4.遮盖渐变过程
        if style.isShowCover {
            let deltaX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
            let deltaW = targetLabel.frame.width - sourceLabel.frame.width
            coverView.frame.origin.x = sourceLabel.frame.origin.x + deltaX * process
            coverView.frame.size.width = sourceLabel.frame.width + deltaW * process
            
        }
        
        
    }
}

// MARK:- 对外暴露的方法
extension STTitlesView {
    func setTitleWithProgress(progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        // 1.取出sourceLabel/targetLabel
        let sourceLabel = labelArray[sourceIndex]
        let targetLabel = labelArray[targetIndex]
        
        // 3.颜色的渐变(复杂)
        // 3.1.取出变化的范围
        let colorDelta = (selectedColorRGB.0 - normalColorRGB.0, selectedColorRGB.1 - normalColorRGB.1, selectedColorRGB.2 - normalColorRGB.2)
        // 3.2.变化sourceLabel
        sourceLabel.textColor = UIColor(r: selectedColorRGB.0 - colorDelta.0 * progress, g: selectedColorRGB.1 - colorDelta.1 * progress, b: selectedColorRGB.2 - colorDelta.2 * progress)
        // 3.2.变化targetLabel
        targetLabel.textColor = UIColor(r: normalColorRGB.0 + colorDelta.0 * progress, g: normalColorRGB.1 + colorDelta.1 * progress, b: normalColorRGB.2 + colorDelta.2 * progress)
        // 4.记录最新的index
        currentIndex = targetIndex
        
        
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveTotalW = targetLabel.frame.width - sourceLabel.frame.width
        
        // 5.计算滚动的范围差值
        if style.isShowScrollLine {
            bottomLine.frame.size.width = sourceLabel.frame.width + moveTotalW * progress
            bottomLine.frame.origin.x = sourceLabel.frame.origin.x + moveTotalX * progress
        }
        
        // 6.放大的比例
        if style.isNeedScale {
            /*
            style.scaleRange - scaleDelta
            */
            let scaleDelta = (style.scaleRange - 1.0) * progress
            sourceLabel.transform = CGAffineTransformMakeScale(style.scaleRange - scaleDelta, style.scaleRange - scaleDelta)
            targetLabel.transform = CGAffineTransformMakeScale(1.0 + scaleDelta, 1.0 + scaleDelta)
        }
        
        
        // 7.计算cover的滚动
        if style.isShowCover {
            coverView.frame.size.width = style.isScrollEnable ? (sourceLabel.frame.width + 2 * style.coverMargin + moveTotalW * progress) : (sourceLabel.frame.width + moveTotalW * progress)
            coverView.frame.origin.x = style.isScrollEnable ? (sourceLabel.frame.origin.x - style.coverMargin + moveTotalX * progress) : (sourceLabel.frame.origin.x + moveTotalX * progress)
        }
    }
    
}
