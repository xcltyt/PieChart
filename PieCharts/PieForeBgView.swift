//
//  PieForeBgView.swift
//  PieCharts
//
//  Created by Kivi Berry on 2017/7/26.
//  Copyright © 2017年 Kivi Berry. All rights reserved.
//

import UIKit

class PieForeBgView: UIView {

    var selectBlock:((_ angle:CGFloat, _ p: CGPoint)->())?
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch:AnyObject in touches {
            if let t:UITouch = touch as? UITouch {
                self.toucheBegan(t, with: event)
            }
        }
        
    }
    
    
    func toucheBegan(_ touch: UITouch, with event: UIEvent?) {
        let posi:CGPoint = touch.location(in: self)
        
        if ((posi.x - self.frame.size.width/2)*(posi.x - self.frame.size.width/2) + (posi.y - self.frame.size.height/2)*(posi.y - self.frame.size.height/2) > (self.frame.size.height * self.frame.size.height)) {
            return
        }
        
        //计算角度后调用block
        let aLen2 = (posi.x - self.frame.size.width/2)*(posi.x - self.frame.size.width/2) + (posi.y - self.frame.size.width/2)*(posi.y - self.frame.size.width/2)
        let aLen : CGFloat = sqrt(aLen2)
        
        let cLen2 = self.frame.size.width/2 * self.frame.size.width/2
        let cLen = self.frame.size.width/2
        
        let bLen2 = (posi.x - self.frame.size.width)*(posi.x - self.frame.size.width) + (posi.y - self.frame.size.width/2)*(posi.y - self.frame.size.width/2)
        var angle = acos((aLen2 + cLen2 - bLen2)/2/aLen/cLen)
        
        if posi.y < self.frame.size.height/2 {
            angle = CGFloat(Double.pi * 2) - angle
        }
        if let  block = selectBlock {
            block(angle, posi)
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
