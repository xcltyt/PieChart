//
//  PieChart.swift
//  PieCharts
//
//  Created by Kivi Berry on 2017/7/26.
//  Copyright © 2017年 Kivi Berry. All rights reserved.
//

import UIKit

class PieChart: BaseChart {

    var valueArr: NSArray = NSArray()
    
    var descArr : NSArray = NSArray()
    
    var colorArr : NSArray = NSArray()
    
    var positionChangeLengthWhenClick:CGFloat?
    
    var showDescripotion : Bool?
    
    var pieForeView = PieForeBgView()
    
    var allValueCount:Float?
    
    var angleArr : NSMutableArray = NSMutableArray()
    
    var countPreAngeleArr: NSMutableArray = NSMutableArray()
    
    var layersArr:NSMutableArray = NSMutableArray()
    
    var saveIndex:NSInteger?
    
    var chartArcLength:CGFloat?
    
    var showInfoView:ShowInfoView = ShowInfoView()

    let k_color_stock:[UIColor] = [UIColor(red: 244/255.0, green: 161/255.0, blue: 100/255.0, alpha: 1),UIColor(red: 87/255.0, green: 255/255.0, blue: 191/255.0, alpha: 1),UIColor(red: 254/255.0, green: 224/255.0, blue: 90/255.0, alpha: 1),UIColor(red: 240/255.0, green: 58/255.0, blue: 63/255.0, alpha: 1),UIColor(red: 147/255.0, green: 111/255.0, blue: 255/255.0, alpha: 1),UIColor(red: 255/255.0, green: 255/255.0, blue: 100/255.0, alpha: 1),UIColor(red: 100/255.0, green: 150/255.0, blue: 63/255.0, alpha: 1),UIColor(red: 50/255.0, green: 250/255.0, blue: 63/255.0, alpha: 1),UIColor(red: 220/255.0, green: 200/255.0, blue: 100/255.0, alpha: 1),UIColor(red: 180/255.0, green: 66/255.0, blue: 120/255.0, alpha: 1),UIColor(red: 44/255.0, green: 244/255.0, blue: 150/255.0, alpha: 1),UIColor(red: 20/255.0, green: 250/255.0, blue: 220/255.0, alpha: 1),UIColor(red: 120/255.0, green: 150/255.0, blue: 20/255.0, alpha: 1),UIColor(red: 220/255.0, green: 250/255.0, blue: 120/255.0, alpha: 1)]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        chartArcLength = 8.0
        showDescripotion = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ rect: CGRect) {
        
        let context:CGContext = UIGraphicsGetCurrentContext()!
        
        if self.descArr.count == self.valueArr.count && self.descArr.count > 0 {
            var colors = NSArray()
            if self.colorArr.count == self.valueArr.count {
                colors = self.colorArr
            } else {
                colors = k_color_stock as NSArray
            }
            
            if !(self.showDescripotion!) {
                return
            }
            
            for i in 0...self.descArr.count-1 {
                
                self.drawQuart(color: colors[i%colors.count] as! UIColor, p: CGPoint(x: 15 + self.frame.size.width/2 * CGFloat(i%2), y:CGFloat(20 * (i/2) + 25) + self.chartArcLength! * 2), context: context)
                let value:Float = (self.valueArr[i] as! NSNumber).floatValue
                let present:Float = value/self.allValueCount!*100
                let str1:NSString = "%@ 数量:%@ 占比:%.1f%@"
                let str2:NSString = self.descArr[i] as! NSString
                let str3:NSString = "\(self.valueArr[i])" as NSString
                let str = NSString(format: str1, str2, str3, present, "%")
                self.drawText(context: context, text: str, pointN: CGPoint(x: 30 + self.frame.size.width/2 * CGFloat(i%2), y: CGFloat(20 * (i/2) + 25) + self.chartArcLength! * 2), color: UIColor.black, fontSize: 8)
            }
            
            
        }
        
        
        
        
    }
    
    override func drawText(context: CGContext, text: NSString, pointN: CGPoint, color: UIColor, fontSize: CGFloat) {
        let textStr = NSString(format: text, "%@")
        textStr.draw(at: pointN, withAttributes: [NSFontAttributeName:UIFont.init(name: "CourierNewPSMT", size: fontSize)!,NSForegroundColorAttributeName:color])
        color.setFill()
        context.drawPath(using: .fill)
    }
    
    func countAllValue() {
        self.allValueCount = 0
        for obj:Any in self.valueArr {
            self.allValueCount! += (obj as! NSNumber).floatValue
        }
    }
    
    func countAllAngleDataArr() {
        self.angleArr = NSMutableArray(capacity: 0)
        for obj:Any in self.valueArr {
            let value = (obj as! NSNumber).floatValue
            self.angleArr.add(NSNumber(value: value * Float(Double.pi) * 2/Float(self.allValueCount!)))
        }
        self.countPreAngeleArr = NSMutableArray(capacity: 0)
        
        for i in 0...self.angleArr.count-1 {
            if i == 0 {
                self.countPreAngeleArr.add(NSNumber(value: 0))
            }
            var angle:Float = 0.0
            for j in 0...i {
                let value = (self.angleArr[j] as! NSNumber)
                angle += Float(value.floatValue)
            }
            self.countPreAngeleArr.add(NSNumber(value: angle))
        }
    }
    
    override func showAnimation() {
        if self.valueArr.count > 0 {
            self.countAllValue()
            self.countAllAngleDataArr()
            self.layersArr = NSMutableArray(capacity: 0)
            var wid:CGFloat = self.frame.size.width - 20
            self.chartOrigin = CGPoint(x: 10 + wid/2, y: 15+wid/2)
            if self.descArr.count > 0 {
                let i = self.descArr.count/2 + self.descArr.count%2
                wid = self.frame.size.height - CGFloat(10 + i*25)
            }
            self.chartArcLength = wid/2
            var colors = NSArray()
            if self.colorArr.count == self.valueArr.count {
                colors = self.colorArr
            } else {
                colors = k_color_stock as NSArray
            }
            
            for i in 0...self.countPreAngeleArr.count-2 {
                let itemsView = PieItemsView(frame: CGRect(x: 10, y: 10, width: wid/2, height: wid/2), beginAngle: CGFloat((self.countPreAngeleArr[i] as! NSNumber).floatValue) , endAngle: CGFloat((self.countPreAngeleArr[i+1] as! NSNumber).floatValue), fillColor: colors[i%colors.count] as! UIColor)
                itemsView.center = CGPoint(x: self.frame.size.width/2, y: 10 + wid/2)
                itemsView.tag = i
                self.layersArr.add(itemsView)
                self.addSubview(itemsView)
            }
            
            pieForeView = PieForeBgView(frame: CGRect(x: 10, y: 10, width: wid, height: wid))
            pieForeView.center = CGPoint(x: self.frame.size.width/2, y: 10+wid/2)
            pieForeView.backgroundColor = UIColor.clear
            
            if self.showInfoView.superview == nil {
                self.showInfoView = ShowInfoView()
                self.showInfoView.isHidden = true
                self.pieForeView.addSubview(self.showInfoView)
            }
            
            pieForeView.selectBlock = { [unowned self] (angle:CGFloat, p:CGPoint) in
                self.judgeWhitchOneIsNow(angle: angle, p: p)
                
            }
            self.addSubview(pieForeView)
        }
        self.setNeedsDisplay()
    }
    
    func judgeWhitchOneIsNow(angle:CGFloat, p:CGPoint) {
        for i in 0...self.countPreAngeleArr.count-2 {
            if CGFloat((self.countPreAngeleArr[i+1] as! NSNumber).floatValue) >= angle {
                let NOW_ANGLE = (self.countPreAngeleArr[i] as! NSNumber).floatValue + (self.angleArr[i] as! NSNumber).floatValue/2.0
                
                let standarSpa = self.positionChangeLengthWhenClick
                let spa:CGFloat = CGFloat(sin(NOW_ANGLE)) * standarSpa!
                let xSpa:CGFloat = CGFloat(cos(NOW_ANGLE)) * standarSpa!
                
                let itemsView:PieItemsView = self.layersArr[i] as! PieItemsView
                var index:NSInteger = 0
                if let ind = self.saveIndex {
                    index = ind
                }
                let saveItems:PieItemsView = self.layersArr[index] as! PieItemsView
                
                var wid:CGFloat = self.frame.size.width - 20
                
                if self.descArr.count  > 0 {
                    let i = self.descArr.count/2 + self.descArr.count%2
                    wid = self.frame.size.height - CGFloat(10 + i*25)
                }
                var colors:NSArray = NSArray()
                if self.colorArr.count == self.valueArr.count {
                    colors = self.colorArr
                } else {
                    colors = k_color_stock as NSArray
                }
                
                let value:Float = (self.valueArr[i] as! NSNumber).floatValue
                let present:Float = value/self.allValueCount!*100
                let str1:NSString = "%@ 数量:%@ 占比:%.1f%@"
                let str2:NSString = self.descArr[i] as! NSString
                let str3:NSString = "\(value)" as NSString
                let str = NSString(format: str1, str2, str3, present, "%")
                
                UIView.animate(withDuration: 0.3, animations: {
                    if self.saveIndex == i {
                        if saveItems.center.x == self.frame.size.width/2 {
                            self.showInfoView.isHidden = false
                            itemsView.center = CGPoint(x: self.frame.size.width/2+xSpa, y: 10+wid/2+spa)
                            self.showInfoView.updateFrame(frame: CGRect(x: p.x, y:p.y, width: self.showInfoView.frame.size.width, height: self.showInfoView.frame.size.height), bgColor: colors[i%colors.count] as! UIColor, contentString: str)
                        } else {
                            self.showInfoView.isHidden = true
                            saveItems.center = CGPoint(x: self.frame.size.width/2, y: 10+wid/2)
                        }
                    } else {
                        saveItems.center = CGPoint(x: self.frame.size.width/2, y: 10+wid/2)
                        self.showInfoView.isHidden = false
                        itemsView.center = CGPoint(x: self.frame.size.width/2+xSpa, y: 10+wid/2+spa)
                        self.showInfoView.updateFrame(frame: CGRect(x: p.x, y:p.y, width: self.showInfoView.frame.size.width, height: self.showInfoView.frame.size.height), bgColor: colors[i%colors.count] as! UIColor, contentString: str)
                    }
                })
                self.saveIndex = i
                break
            }
            
        }
        
    }
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
