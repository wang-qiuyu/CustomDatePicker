//
//  ViewController.swift
//  CustomDatePicker
//
//  Created by qiuyu on 2017/12/7.
//  Copyright © 2017年 qiuyu wang. All rights reserved.
//

import UIKit

public let Screen_Width:CGFloat = UIScreen.main.bounds.size.width
public let Screen_Height:CGFloat = UIScreen.main.bounds.size.height

public let MAXYEAR = 2100
public let MINYEAR = 1970

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let leftRect = CGRect(x:Screen_Width/2-100 ,y:100, width:200, height:100 )
        let leftBtn = UIButton(frame: leftRect)
        leftBtn.backgroundColor = UIColor.orange
        leftBtn.setTitle("runtime方式", for: UIControlState.normal)
        leftBtn.addTarget(self, action:#selector(dateBtnClick), for: UIControlEvents.touchUpInside)
        self.view.addSubview(leftBtn)
        
        let rightRect = CGRect(x:Screen_Width/2-100 ,y:250, width:200, height:100 )
        let rightBtn = UIButton(frame: rightRect)
        rightBtn.setTitle("自定义pickerview方式", for: UIControlState.normal)
        rightBtn.backgroundColor = UIColor.red
        rightBtn.addTarget(self, action:#selector(pickerBtnClick), for: UIControlEvents.touchUpInside)
        self.view.addSubview(rightBtn)
    }

    @objc func dateBtnClick(){
        
        let datePickView = DatePickerView.init(frame: CGRect(x:0,y:0,width:Screen_Width,height:Screen_Height))
        datePickView.show()
        
    }
    @objc func pickerBtnClick(){
        let customView = CustomPickerView.init(frame: CGRect(x:0,y:0,width:Screen_Width,height:Screen_Height))
        customView.show()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

