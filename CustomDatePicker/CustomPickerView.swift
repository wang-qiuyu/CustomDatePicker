//
//  CustomPickerView.swift
//  CustomDatePicker
//
//  Created by qiuyu on 2017/12/7.
//  Copyright © 2017年 qiuyu wang. All rights reserved.
//

import UIKit

class CustomPickerView: UIView,UIPickerViewDelegate,UIPickerViewDataSource {

    //日期存储数组
    var yearArray:NSMutableArray?
    var monthArray:NSMutableArray?
    var dayArray:NSMutableArray?
    //记录日期位置
    var yearIndex:NSInteger?
    var monthIndex:NSInteger?
    var dayIndex:NSInteger?
    
    
    func show () {
        let window = UIApplication.shared.keyWindow
        window?.addSubview(self)
    }
    @objc func closeClickBtn() {
        self.removeFromSuperview()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    func setupUI()  {
        
        self.defaultConfig()
        
        self.insertSubview(self.grayView, belowSubview: self)
        
        self.grayView.addSubview(self.backView)
        self.backView.addSubview(self.datePicker)
        
        let currentDate = NSDate()
        self.scrollToDate(date: currentDate)
    }
    fileprivate func scrollToDate (date:NSDate) {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.day,.month,.year,.hour], from: date as Date)
        let _ = self.daysCount(year: dateComponents.year!, month: dateComponents.month!)
        
        yearIndex = dateComponents.year!-MINYEAR
        monthIndex = dateComponents.month!-1
        dayIndex = dateComponents.day!-1
        
        self.datePicker.reloadAllComponents()
        self.datePicker.selectRow(yearIndex!, inComponent: 0, animated: true)
        self.datePicker.selectRow(monthIndex!, inComponent: 1, animated: true)
        self.datePicker.selectRow(dayIndex!, inComponent: 2, animated: true)
        
    }
    
    fileprivate func defaultConfig(){
        yearArray = NSMutableArray.init()
        monthArray = NSMutableArray.init()
        dayArray = NSMutableArray.init()
        
        yearIndex = 0
        monthIndex = 0
        dayIndex = 0
        
        for i in 1...12 {
            let monthStr = String(format:"%02d",i)
            monthArray?.add(monthStr)
        }
        for i in MINYEAR...MAXYEAR {
            let yearStr = String(format:"%d",i)
            yearArray?.add(yearStr)
        }
    }
    /// 计算每个月的天数
    fileprivate func daysCount(year:Int,month:Int) -> Int{
        let isrunNian = year%4 == 0 ? (year%100 == 0 ? (year%400 == 0 ? true:false):true):false
        if month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12{
            self.setDayArr(num: 31)
            return 31
        }else if month == 4 || month == 6 || month == 9 || month == 11{
            self.setDayArr(num: 30)
            return 30
        }else if month == 2{
            if isrunNian{
                self.setDayArr(num: 29)
                return 29
            }else{
                self.setDayArr(num: 28)
                return 28
            }
        }
        return 0
    }
    fileprivate func setDayArr(num:NSInteger){
        dayArray?.removeAllObjects()
        for i in 1...num {
            let dayStr = String(format:"%02d",i)
            dayArray?.add(dayStr)
        }
    }
    //MARK: 代理方法
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let yearNum = yearArray?.count
        let monthNum = monthArray?.count
        
        let selctYear = (yearArray![yearIndex!] as! NSString).intValue
        let selctMonth = (monthArray![monthIndex!] as! NSString).intValue
        
        let dayNum = self.daysCount(year: Int(selctYear) , month: Int(selctMonth))
        let numberArr = [yearNum,monthNum,dayNum]
        return numberArr[component]!
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let headLabel = UILabel.init()
        headLabel.textColor  = UIColor.red
        headLabel.textAlignment = NSTextAlignment.center
        if component == 0 {
            headLabel.text = yearArray?[row] as? String
        }
        if component == 1 {
            headLabel.text = monthArray?[row] as? String
        }
        if component == 2 {
            headLabel.text = dayArray?[row] as? String
        }
//        pickerView.subviews[1].backgroundColor = UIColor.clear
//        pickerView.subviews[2].backgroundColor = UIColor.clear
        
        return headLabel
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            yearIndex = row
        }
        if component == 1 {
            monthIndex = row
        }
        if component == 2 {
            dayIndex = row
        }
        if component == 0 || component == 1{
            let selctYear = (yearArray![yearIndex!] as! NSString).intValue
            let selctMonth = (monthArray![monthIndex!] as! NSString).intValue
            let _ = self.daysCount(year: Int(selctYear) , month: Int(selctMonth))
            
            if (dayArray?.count)!-1 < dayIndex! {
                dayIndex = (dayArray?.count)!-1
            }
        }
        pickerView.reloadAllComponents()
        
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
    lazy var datePicker:UIPickerView = {
        let view = UIPickerView.init()
        view.frame = CGRect(x:0, y:0, width:Screen_Width-60, height:245)
        view.showsSelectionIndicator = true
        view.delegate = self
        view.dataSource = self
        return view
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
