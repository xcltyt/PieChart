//
//  ShowInfoView.swift
//  PieCharts
//
//  Created by Kivi Berry on 2017/7/26.
//  Copyright © 2017年 Kivi Berry. All rights reserved.
//

import UIKit

class ShowInfoView: UIView {

    
    
    var bgLabel:UILabel = UILabel()
    
    var showContentString:NSString = "" {
        didSet {
            let size:CGSize = showContentString.boundingRect(with: CGSize(width: 50, height: 100), options: [.truncatesLastVisibleLine,.usesFontLeading,.usesLineFragmentOrigin], attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 8)], context: nil).size
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: size.width+10, height: 30)
            
            if (bgLabel.superview == nil) {
                bgLabel = UILabel(frame: self.bounds)
                bgLabel.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
                bgLabel.backgroundColor = UIColor.clear
                bgLabel.font = UIFont.systemFont(ofSize: 8)
                bgLabel.numberOfLines = 3
                self.addSubview(bgLabel)
            }
            bgLabel.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            bgLabel.text = showContentString as String
            bgLabel.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateFrame(frame:CGRect, bgColor:UIColor, contentString:NSString) {
        
        self.showContentString = contentString
        
        UIView.animate(withDuration: 0.5, animations: { 
            self.layer.borderColor = bgColor.cgColor
            self.center = CGPoint(x: frame.origin.x, y: frame.origin.y)
        }) { (finished) in
        
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
