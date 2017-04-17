//
//  ChooseColorViewController.swift
//  InstaPlan
//
//  Created by 康壮伟 on 4/16/17.
//  Copyright © 2017 Zhuangwei Kang. All rights reserved.
//

import UIKit

var classPickedColor: String!
var assignmentPickedColor: String!
var taskPickedColor: String!
var askfrom: String!

class ChooseColorViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate  {


    @IBOutlet weak var colorPicker: UIPickerView!
    
    let pickerData = ["Blue", "Brown", "DarkGray", "Green", "Magenta", "Orange", "Red", "Yellow", "While"]
    
    let colorDict = ["Blue": UIColor.blue, "Brown": UIColor.brown, "DarkGray": UIColor.darkGray, "Green": UIColor.green, "Magenta": UIColor.magenta, "Orange": UIColor.orange, "Red": UIColor.red, "Yellow": UIColor.yellow, "While": UIColor.white ]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        colorPicker.dataSource = self
        colorPicker.delegate = self
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }
    
   

    @IBAction func done_action(_ sender: Any) {
        self.view.removeFromSuperview()
        askfrom = ""
    }
    
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    //MARK: Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = pickerData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.black])
        pickerLabel.attributedText = myTitle
        pickerLabel.backgroundColor = colorDict[pickerData[row]]
        pickerLabel.textAlignment = .center
        
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 36.0
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 200
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch askfrom {
        case "class":
            classPickedColor = "Class Color: " + pickerData[row]
        case "assignment":
            assignmentPickedColor = "Assignment Color: " + pickerData[row]
        case "task":
            taskPickedColor = "Task Color: " + pickerData[row]
        default:
            print("some error happened.")
        }
    }
    
    
}
