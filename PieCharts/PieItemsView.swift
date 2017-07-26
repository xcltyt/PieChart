//
//  PieItemsView.swift
//  PieCharts
//
//  Created by Kivi Berry on 2017/7/26.
//  Copyright © 2017年 Kivi Berry. All rights reserved.
//

import UIKit

class PieItemsView: UIView {

    var  beginAngle:CGFloat = 0.0
    
    var endAngle:CGFloat = 0.0
    
    var fillColor:UIColor = UIColor()
    
    var shapeLayer:CAShapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame:CGRect, beginAngle:CGFloat, endAngle:CGFloat, fillColor:UIColor) {
        self.init(frame: frame)
        self.beginAngle = beginAngle
        self.endAngle = endAngle
        self.fillColor = fillColor
        
        self.configBaseLayer()
    }
    
    func configBaseLayer() {
        self.shapeLayer = CAShapeLayer.init(layer: layer)
        let path: UIBezierPath = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2), radius: self.frame.size.width/2, startAngle: self.beginAngle, endAngle: self.endAngle, clockwise: true)
        
        self.shapeLayer.path = path.cgPath
        self.shapeLayer.lineWidth = self.frame.size.width
        self.shapeLayer.strokeColor = self.fillColor.cgColor
        self.shapeLayer.fillColor = UIColor.clear.cgColor
        self.shapeLayer.borderColor = UIColor.clear.cgColor
        self.layer.addSublayer(self.shapeLayer)
        
        let basic: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basic.duration = 1.1
        basic.fromValue = 0.1
        basic.toValue = 1.0
        self.shapeLayer.add(basic, forKey: "basic")
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch \(self.tag)")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
