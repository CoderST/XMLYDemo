//
//  STCatAnimationView.swift
//  XMLYDemo
//
//  Created by xiudou on 2016/12/30.
//  Copyright © 2016年 CoderST. All rights reserved.
//

import UIKit
fileprivate let start_x : CGFloat = 160
fileprivate let start_y : CGFloat = 50
fileprivate let margin_x : CGFloat = 4
fileprivate let margin_y : CGFloat = margin_x
class STCatAnimationView: UIView {
    
    fileprivate var progressPath : UIBezierPath!
    fileprivate var progressLayer : CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 1 创建路径
        progressPath = UIBezierPath()
        progressPath.move(to: CGPoint(x: start_x, y: start_y))//a
        progressPath.addLine(to: CGPoint(x: start_x, y: start_y - 4 * margin_y))//b
        progressPath.addLine(to: CGPoint(x: start_x - 2 * margin_x, y: start_y - 4 * margin_y))//c
        progressPath.addLine(to: CGPoint(x: start_x - margin_x, y: start_y - 8 * margin_y))//d
        progressPath.addLine(to: CGPoint(x: start_x, y: start_y - 6 * margin_y))//e
        progressPath.addLine(to: CGPoint(x: start_x + 2 * margin_x, y: start_y - 6 * margin_y))//f
        progressPath.addLine(to: CGPoint(x: start_x + 3 * margin_x, y: start_y - 8 * margin_y))//g
        progressPath.addLine(to: CGPoint(x: start_x + 4 * margin_x, y: start_y - 4 * margin_y))//h
        progressPath.addLine(to: CGPoint(x: start_x + 2 * margin_x, y: start_y - 4 * margin_y))//i
        progressPath.addLine(to: CGPoint(x: start_x + 2 * margin_x, y: start_y))//j
        progressPath.addLine(to: CGPoint(x: start_x - margin_x, y: start_y))//k
        progressPath.addLine(to: CGPoint(x: start_x - margin_x, y: start_y - 2 * margin_y))//l
        progressPath.addLine(to: CGPoint(x: start_x - 3 * margin_x, y: start_y - 2 * margin_y))//m
        
        // 2 创建CAShapeLayer
        progressLayer = CAShapeLayer()
        progressLayer.lineWidth = 1
        progressLayer.strokeColor = UIColor.red.cgColor
        progressLayer.fillColor =  UIColor.clear.cgColor
        progressLayer.path = progressPath.cgPath
        progressLayer.strokeStart = 0
        // 3 添加layer
        layer.addSublayer(progressLayer)
        
        
        //        self.earPath = [UIBezierPath bezierPath];
        //        self.earPath.lineCapStyle = kCGLineCapRound;
        //        self.earPath.lineJoinStyle = kCGLineJoinRound;
        //        self.earPath.lineWidth = 2.0f;
        //        [self.earPath moveToPoint:CGPointMake(start_x - margin_x, start_y - 2 * margin_y)];//n
        //        [self.earPath addLineToPoint:CGPointMake(start_x - margin_x, start_y - 2 * margin_y)];//o
        //
        //        [self.earPath moveToPoint:CGPointMake(start_x + margin_x, start_y - 2 * margin_y)];//p
        //        [self.earPath addLineToPoint:CGPointMake(start_x + 2 * margin_x, start_y - 2 * margin_y)];//q
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension STCatAnimationView {
    /** progress: 0 ~ 1 */
    func startAnimationWithProgress(progress : CGFloat){
        if (progress >= 1) {
            self.progressLayer.strokeEnd = 1
        }else{
            progressLayer.strokeEnd = progress
        }
        
    }
}
