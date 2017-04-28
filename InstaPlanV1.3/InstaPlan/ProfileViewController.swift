//
//  ProfileViewController.swift
//  InstaPlan
//
//  Created by 康壮伟 on 4/15/17.
//  Copyright © 2017 Zhuangwei Kang. All rights reserved.
//

import UIKit

var chooseColorFrom: String!

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var task_num_label: UILabel!
    @IBOutlet weak var task_num_stepper: UIStepper!
    @IBOutlet weak var notification_hour: UITextField!
    @IBOutlet weak var choose_color_for_class_btn: UIButton!
    @IBOutlet weak var choose_color_for_assignment_btn: UIButton!
    @IBOutlet weak var choose_color_for_task_btn: UIButton!
    @IBOutlet weak var choose_theme_btn: UIButton!
    @IBOutlet weak var edit_btn: UIButton!
    @IBOutlet weak var done_btn: UIButton!
    
    
    func updateUI() {
        if (chooseColorFrom == "class") {
            choose_color_for_class_btn.setTitle("Class color: " + pickedColor, for: .normal)
        }else if(chooseColorFrom == "assignment"){
            choose_color_for_assignment_btn.setTitle("Assignment color: " + pickedColor, for: .normal)
        }else if(chooseColorFrom == "task"){
            choose_color_for_task_btn.setTitle("Task color: " + pickedColor, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProfile()
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileViewController.updateUI), name: NSNotification.Name(rawValue: "UpdateChooseColorButton"), object: nil)
    }

    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setUpProfile() {
        let username = CoreDataController().getUserName().uppercased()
        var userProfileImage: UIImage!
        if username.characters.count == 1 {
            userProfileImage = UIImage(named: username)
        }
        else{
            userProfileImage = UIImage(named: "DefaultProfileImage")
        }
        profileImageView.image = userProfileImage
        
        self.username.text = CoreDataController().getFullUserName()
        self.email.text = CoreDataController().getEmailAddress()
    
        task_num_stepper.isHidden = true
        notification_hour.isEnabled = false
        choose_color_for_class_btn.isEnabled = false
        choose_theme_btn.isEnabled = false
        choose_color_for_task_btn.isEnabled = false
        choose_color_for_assignment_btn.isEnabled = false
        done_btn.isHidden = true
        task_num_stepper.maximumValue = 9
        task_num_stepper.minimumValue = 1
        task_num_stepper.value = 3
        
    }
    
    
    
    @IBAction func task_number_stepper_action(_ sender: Any) {
        task_num_label.text = String(task_num_stepper.value)
    }
    
    @IBAction func choose_color_for_class_action(_ sender: Any) {
        
        chooseColor(from: "class")
    }
    
    @IBAction func choose_color_for_assignment_action(_ sender: Any) {
        
        chooseColor(from: "assignment")
    }
    
    @IBAction func choose_color_for_task_action(_ sender: Any) {
        
        chooseColor(from: "task")
    }
    
    @IBAction func choose_theme(_ sender: Any) {
        
    }
    
    func chooseColor(from: String) {
        chooseColorFrom = from
        
        let popChooseColorView = UIStoryboard(name: "HomePage", bundle: nil).instantiateViewController(withIdentifier: "ChooseColor") as! ChooseColorViewController
        
        
        self.addChildViewController(popChooseColorView)
        popChooseColorView.view.frame = self.view.frame
        self.view.addSubview(popChooseColorView.view)
        popChooseColorView.didMove(toParentViewController: self)
    }
    
    @IBAction func edit_action(_ sender: Any) {
        task_num_stepper.isHidden = false
        notification_hour.isEnabled = true
        choose_color_for_class_btn.isEnabled = true
        choose_theme_btn.isEnabled = true
        choose_color_for_task_btn.isEnabled = true
        choose_color_for_assignment_btn.isEnabled = true
        done_btn.isHidden = false
    }
    
    @IBAction func logout(_ sender: Any) {
        CoreDataController().resetLoginStatus(email_address: currentUserEmail)
        let mainpage = UIStoryboard(name: "SignupandLogin", bundle: nil)
        let vc = mainpage.instantiateInitialViewController()
        show(vc!, sender: self)
    }
    
    @IBAction func done_action(_ sender: Any) {
        task_num_stepper.isHidden = true
        notification_hour.isEnabled = false
        choose_color_for_class_btn.isEnabled = false
        choose_theme_btn.isEnabled = false
        choose_color_for_task_btn.isEnabled = false
        choose_color_for_assignment_btn.isEnabled = false
        done_btn.isHidden = true
        
        CoreDataController().store_settings(
            task_num: get_task_num(),
            notification: get_notification_num(),
            class_color: get_class_color(),
            assignment_color: get_assignment_color(),
            task_color: get_task_color())
        
        let alert = UIAlertController(title: "Setting updated", message: "Your setting has been saved.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func get_class_color()-> String{
        var class_color = self.choose_color_for_class_btn.title(for: .normal)
        class_color = (class_color! as NSString).substring(from: 12)
        return class_color!
    }
    
    func get_assignment_color() -> String {
        var assignment_color = self.choose_color_for_assignment_btn.title(for: .normal)
        assignment_color = (assignment_color! as NSString).substring(from: 17)
        return assignment_color!
    }
    
    func get_task_color() -> String {
        var task_color = self.choose_color_for_task_btn.title(for: .normal)
        task_color = (task_color! as NSString).substring(from: 11)
        return task_color!
    }
    
    func get_task_num() -> Int16 {
        let task_num: Int16 = Int16((task_num_label.text! as NSString).intValue)
        return task_num
    }
    
    func get_notification_num() -> Int16 {
        let notif_num: Int16 = Int16((self.notification_hour.text! as NSString).intValue)
        return notif_num
    }
}
