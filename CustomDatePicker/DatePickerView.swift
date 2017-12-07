//
//  DatePickerView.swift
//  CustomDatePicker
//
//  Created by qiuyu on 2017/12/7.
//  Copyright © 2017年 qiuyu wang. All rights reserved.
//

import UIKit

class DatePickerView: UIView {

    func show () {
        let window = UIApplication.shared.keyWindow
        window?.addSubview(self)
    }
    @objc func closeClickBtn() {
        self.removeFromSuperview()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.insertSubview(self.grayView, belowSubview: self)

        self.grayView.addSubview(self.backView)
        self.backView.addSubview(self.datePicker)
        self.setDateTextColor(picker: self.datePicker)
    }
    
    //MARK:runtime遍历所有属性名，并加以修改
    func setDateTextColor(picker:UIDatePicker){
        var count:UInt32 = 0
        let propertys = class_copyPropertyList(UIDatePicker.self, &count)
        for index in 0..<count {
            let i = Int(index)
            let property = propertys![i]
            let propertyName = property_getName(property)
            
            let strName = String.init(cString: propertyName, encoding: String.Encoding.utf8)
            if strName == "textColor"{
                picker.setValue(UIColor.red, forKey: strName!)
            }
        }
    }
    
    lazy var backView:UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.white
        view.frame = CGRect(x:30, y:Screen_Height/2-125, width:Screen_Width-60, height:250)
        view.layer.cornerRadius = 5.0
        return view
    }()
    lazy var grayView:UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.frame = CGRect(x:0,y:0,width:Screen_Width,height:Screen_Height)
        view.addGestureRecognizer(UITapGestureRecognizer(target:self,action:#selector(closeClickBtn)))
        return view
    }()
    lazy var datePicker:UIDatePicker = {
        let view = UIDatePicker.init()
        view.frame = CGRect(x:0, y:0, width:Screen_Width-60, height:245)
        view.datePickerMode =  UIDatePickerMode.date
        return view
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
