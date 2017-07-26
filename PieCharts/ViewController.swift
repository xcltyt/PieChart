//
//  ViewController.swift
//  PieCharts
//
//  Created by Kivi Berry on 2017/7/26.
//  Copyright © 2017年 Kivi Berry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        
        //绘制饼状图
        self.showPieChartsView()
        
        
    }
    
    
    func showPieChartsView() {
        let pie:PieChart = PieChart(frame: CGRect(x: 100, y: 100, width: 321, height: 421))
        pie.backgroundColor = UIColor.white
        pie.center = CGPoint(x: self.view.frame.maxX/2, y: self.view.frame.maxY/2)
        pie.valueArr = [18,14,25,40,23,21,27,50]
        pie.descArr = ["1","2","3","4","5","6","7","8"]
        self.view.addSubview(pie)
        pie.positionChangeLengthWhenClick = 15
        pie.showDescripotion = true
        pie.showAnimation()
    }
    
    
    
    
    
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

