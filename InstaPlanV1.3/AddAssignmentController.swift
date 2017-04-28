//
//  AddAssignmentController.swift
//  InstaPlan
//
//  Created by 康壮伟 on 4/27/17.
//  Copyright © 2017 Zhuangwei Kang. All rights reserved.
//

import UIKit

class AddAssignmentController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var assignment_name_textfield: UITextField!
    
    
    @IBOutlet weak var dueDate_textfield: UITextField!
    
    @IBOutlet weak var class_textfield: UITextField!
    
    @IBOutlet weak var location_textfield: UITextField!
    
    @IBOutlet weak var additional_info_textfield: UITextView!
    
    var priority: Int16 = 0
    
    @IBOutlet weak var star_1: UIButton!
    @IBOutlet weak var star_2: UIButton!
    @IBOutlet weak var star_3: UIButton!
    @IBOutlet weak var star_4: UIButton!
    @IBOutlet weak var star_5: UIButton!
    var star1_clicked: Bool = false
    var star2_clicked: Bool = false
    var star3_clicked: Bool = false
    var star4_clicked: Bool = false
    var star5_clicked: Bool = false
    
    @IBOutlet weak var dueDateTextField: UITextField!
    
    let dueDatePickerView: UIDatePicker = UIDatePicker()
    
    @IBOutlet weak var norice_hour: UITextField!
    
    @IBOutlet weak var advance_hour_stepper: UIStepper!
    
    @IBOutlet weak var red_btn: UIButton!
    @IBOutlet weak var orange_btn: UIButton!
    @IBOutlet weak var yellow_btn: UIButton!
    @IBOutlet weak var green_btn: UIButton!
    @IBOutlet weak var blue_btn: UIButton!
    
    var red_clicked: Bool = false
    var orange_clicked: Bool = false
    var yellow_clicked: Bool = false
    var green_clicked: Bool = false
    var blue_clicked: Bool = false
    
    var assignment_color: String = ""
    
    var classPickOption: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let class_picker_view = UIPickerView()
        class_picker_view.delegate = self
        class_textfield.inputView = class_picker_view
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.blackTranslucent
        
        toolBar.tintColor = UIColor.white
        
        toolBar.backgroundColor = UIColor.black
        
        let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.donePressed))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Helvetica", size: 20)
        
        label.backgroundColor = UIColor.clear
        
        label.textColor = UIColor.white
        
        label.text = "InstaPlan"
        
        label.textAlignment = NSTextAlignment.center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        toolBar.setItems([textBtn, flexSpace, okBarBtn], animated: true)
        
        dueDateTextField.inputAccessoryView = toolBar
        class_textfield.inputAccessoryView = toolBar
        
        dueDatePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        dueDateTextField.inputView = dueDatePickerView
        dueDatePickerView.addTarget(self, action: #selector(self.dueDatePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func getCurrentClasses() {
        classPickOption = CoreDataController().getclasses()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        getCurrentClasses()
        return classPickOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return classPickOption[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.class_textfield.text = classPickOption[row]
    }
    
    func dueDatePickerValueChanged(sender: UIDatePicker) {
        
        let duedateFormatter = DateFormatter()
        
        duedateFormatter.dateStyle = .short
        
        duedateFormatter.timeStyle = .short
        
        dueDateTextField.text = duedateFormatter.string(from: sender.date)
    }
    
    func donePressed() {
        dueDateTextField.resignFirstResponder()
        class_textfield.resignFirstResponder()
    }
    
    @IBAction func cancelAddAssignment(_ sender: Any) {
        goback()
    }
    
    @IBAction func star1(_ sender: Any) {
        if(self.star_action(star: star_1, clicked: star1_clicked)){
            star1_clicked = true
            priority += 1
        }
        else{
            star1_clicked = false
            priority -= 1
        }
    }

    @IBAction func star2(_ sender: Any) {
        if(self.star_action(star: star_2, clicked: star2_clicked)){
            star2_clicked = true
            priority += 1
        }
        else{
            star2_clicked = false
            priority -= 1
        }
    }
    
    @IBAction func star3(_ sender: Any) {
        if(self.star_action(star: star_3, clicked: star3_clicked)){
            star3_clicked = true
            priority += 1
        }
        else{
            star3_clicked = false
            priority -= 1
        }
    }
    
    @IBAction func star4(_ sender: Any) {
        if(self.star_action(star: star_4, clicked: star4_clicked)){
            star4_clicked = true
            priority += 1
        }
        else{
            star4_clicked = false
            priority -= 1
        }
    }
    
    @IBAction func star5(_ sender: Any) {
        if(self.star_action(star: star_5, clicked: star5_clicked)){
            star5_clicked = true
            priority += 1
        }
        else{
            star5_clicked = false
            priority -= 1
        }
    }
    
    func star_action(star: UIButton, clicked: Bool) -> Bool {
        if(!clicked){
            star.setImage(#imageLiteral(resourceName: "star"), for: .normal)
            return true
        }
        else{
            star.setImage(#imageLiteral(resourceName: "empty_star"), for: .normal)
            return false
        }
    }
    
    func goback() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "HomePage", bundle: nil)
        
        let todayView = storyBoard.instantiateViewController(withIdentifier: "startPoint")
        
        self.present(todayView, animated: true, completion: nil)
    }
    
    @IBAction func change_advance_hour(_ sender: Any) {
        self.norice_hour.text = String(self.advance_hour_stepper.value)
    }
    
    @IBAction func red_btn_action(_ sender: Any) {
        if(!self.red_clicked){
            red_btn.setImage(#imageLiteral(resourceName: "red_check"), for: .normal)
            red_clicked = true
            orange_btn.isEnabled = false
            yellow_btn.isEnabled = false
            green_btn.isEnabled = false
            blue_btn.isEnabled = false
            assignment_color = "Red"
        }
        else{
            red_btn.setImage(#imageLiteral(resourceName: "red"), for: .normal)
            red_clicked = false
            orange_btn.isEnabled = true
            yellow_btn.isEnabled = true
            green_btn.isEnabled = true
            blue_btn.isEnabled = true
            assignment_color = ""
        }
    }
    
    @IBAction func orange_btn_action(_ sender: Any) {
        if(!self.orange_clicked){
            orange_btn.setImage(#imageLiteral(resourceName: "orange_check"), for: .normal)
            orange_clicked = true
            red_btn.isEnabled = false
            yellow_btn.isEnabled = false
            green_btn.isEnabled = false
            blue_btn.isEnabled = false
            assignment_color = "Orange"
        }
        else{
            orange_btn.setImage(#imageLiteral(resourceName: "orange"), for: .normal)
            orange_clicked = false
            red_btn.isEnabled = true
            yellow_btn.isEnabled = true
            green_btn.isEnabled = true
            blue_btn.isEnabled = true
            assignment_color = ""
        }
    }

    @IBAction func yellow_btn_action(_ sender: Any) {
        if(!self.yellow_clicked){
            yellow_btn.setImage(#imageLiteral(resourceName: "yellow_check"), for: .normal)
            yellow_clicked = true
            red_btn.isEnabled = false
            orange_btn.isEnabled = false
            green_btn.isEnabled = false
            blue_btn.isEnabled = false
            assignment_color = "Yellow"
        }
        else{
            yellow_btn.setImage(#imageLiteral(resourceName: "yellow"), for: .normal)
            yellow_clicked = false
            red_btn.isEnabled = true
            orange_btn.isEnabled = true
            green_btn.isEnabled = true
            blue_btn.isEnabled = true
            assignment_color = ""
        }
    }
    
    @IBAction func green_btn_action(_ sender: Any) {
        if(!self.green_clicked){
            green_btn.setImage(#imageLiteral(resourceName: "green_check"), for: .normal)
            green_clicked = true
            red_btn.isEnabled = false
            orange_btn.isEnabled = false
            yellow_btn.isEnabled = false
            blue_btn.isEnabled = false
            assignment_color = "Green"
        }
        else{
            green_btn.setImage(#imageLiteral(resourceName: "green"), for: .normal)
            green_clicked = false
            red_btn.isEnabled = true
            orange_btn.isEnabled = true
            yellow_btn.isEnabled = true
            blue_btn.isEnabled = true
            assignment_color = ""
        }
    }
    
    @IBAction func blue_btn_action(_ sender: Any) {
        if(!self.blue_clicked){
            blue_btn.setImage(#imageLiteral(resourceName: "blue_check"), for: .normal)
            blue_clicked = true
            red_btn.isEnabled = false
            orange_btn.isEnabled = false
            yellow_btn.isEnabled = false
            green_btn.isEnabled = false
            assignment_color = "Blue"
        }
        else{
            blue_btn.setImage(#imageLiteral(resourceName: "blue"), for: .normal)
            blue_clicked = false
            red_btn.isEnabled = true
            orange_btn.isEnabled = true
            yellow_btn.isEnabled = true
            green_btn.isEnabled = true
            assignment_color = ""
        }
    }

    @IBAction func store_assignment(_ sender: Any){
        let assignment_name = assignment_name_textfield.text
        let due_date_formatter = DateFormatter()
        due_date_formatter.dateStyle = .short
        due_date_formatter.timeStyle = .short
        let due_date: NSDate = due_date_formatter.date(from: self.dueDateTextField.text!)! as NSDate
        let remind_hours = Double(norice_hour.text!)
        let class_name = class_textfield.text
        let location = location_textfield.text
        let additional_info = additional_info_textfield.text
        CoreDataController().storeAssignment(assignment_name: assignment_name!, due_date: due_date, advanced_notice_hours: remind_hours!, class_name: class_name!, location: location!, color: assignment_color, additional_info: additional_info!, priority: priority)
        goback()
    }
}
