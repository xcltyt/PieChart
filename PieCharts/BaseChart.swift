//
//  BaseChart.swift
//  PieCharts
//
//  Created by Kivi Berry on 2017/7/26.
//  Copyright © 2017年 Kivi Berry. All rights reserved.
//

import UIKit

class BaseChart: UIView {

    //图表的边界值
    var contentInsets : UIEdgeInsets
    
    //图表的原点值
    var chartOrigin : CGPoint
    
    //图表名称
    var chartTitle : String = ""
    
    //x轴文字字体大小
    var  yLineTextFontSize : CGFloat
    
    //y轴文字字体大小
    var  xLineTextFontSize : CGFloat
    
    //xy轴线颜色
    var xyLineColor : UIColor
    
    
    override init(frame: CGRect) {
        self.xLineTextFontSize = 8.0
        self.yLineTextFontSize = 8.0
        self.xyLineColor = UIColor.darkGray
        self.contentInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 10)
        self.chartOrigin = CGPoint(x: self.contentInsets.left, y: frame.height - self.contentInsets.bottom)
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func showAnimation()  {
        
    }
    
    func clear()  {
        
    }
    
    /**
     *  绘制线段
     *
     *  @param context  图形绘制上下文
     *  @param start    起点
     *  @param end      终点
     *  @param isDotted 是否是虚线
     *  @param color    线段颜色
     */
    func drawLine(context: CGContext, start: CGPoint, end: CGPoint, isDotted:Bool, color: UIColor) {
        
        context.move(to: CGPoint(x: start.x, y: start.y))
        context.addLine(to: CGPoint(x: end.x, y: end.y))
        context.setLineWidth(0.3)
        color.setStroke()
        if isDotted {
            let ss:[CGFloat] = [1.5, 2]
            context.setLineDash(phase: 0, lengths: ss)
        }
        context.move(to: CGPoint(x: end.x, y: end.y))
        context.drawPath(using: .fillStroke)
        
    }
    
    /**
     *  绘制文字
     *
     *  @param text    文字内容
     *  @param context 图形绘制上下文
     *  @param rect    绘制点
     *  @param color   绘制颜色
     */
    func drawText(context: CGContext, text: NSString, pointN: CGPoint, color: UIColor, fontSize: CGFloat) {
        let textStr:NSString = NSString.init(format: "%@", text)
        textStr.draw(at: pointN, withAttributes: [NSFontAttributeName:fontSize,NSForegroundColorAttributeName:color])
        color.setFill()
        context.drawPath(using: .fill)
    }
    
    /**
     *  判断文本宽度
     *
     *  @param text 文本内容
     *
     *  @return 文本宽度
     */
    
    func getTextWithWhenDrawWithText(text: NSString) -> CGFloat {
        let textStr = NSString.init(format: text, "%@")
        let size = textStr.boundingRect(with: CGSize(width: 100, height: 15), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 7)], context: nil).size
        return size.width
    }
    
    /**
     *  绘制长方形
     *
     *  @param color  填充颜色
     *  @param p      开始点
     *  @param contex 图形上下文
     */
    func drawQuart(color: UIColor, p: CGPoint, context: CGContext) {
        context.addRect(CGRect(x: p.x, y: p.y, width: 10, height: 10))
        color.setFill()
        color.setStroke()
        context.drawPath(using: .fillStroke)
    }
    
    
    func drawPoint(redius:CGFloat, color: UIColor, p: CGPoint, context:CGContext) {
        context.addArc(center: p, radius: redius, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        color.setFill()
        context.drawPath(using: .fill)
    }
    
    
    /**
     *  返回字符串的占用尺寸
     *
     *  @param maxSize   最大尺寸
     *  @param fontSize  字号大小
     *  @param aimString 目标字符串
     *
     *  @return 占用尺寸
     */
//    | .usesFontLeading | .truncatesLastVisibleLine
    func sizeOfString(maxSize: CGSize, fontSize: CGFloat, aimString: NSString) -> CGSize {
        let str = NSString.init(format: aimString, "%@")
        
        return str.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin, .usesFontLeading, .truncatesLastVisibleLine], attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: fontSize)], context: nil).size
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
