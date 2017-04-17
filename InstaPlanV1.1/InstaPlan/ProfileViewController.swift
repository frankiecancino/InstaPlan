//
//  ProfileViewController.swift
//  InstaPlan
//
//  Created by 康壮伟 on 4/15/17.
//  Copyright © 2017 Zhuangwei Kang. All rights reserved.
//

import UIKit

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
    
    var choose_class_btn_text: String!
    var choose_assignment_btn_text: String!
    var choose_task_btn_text: String!
    
    var choose_class_btn: Bool!
    var choose_assignment_btn: Bool!
    var choose_task_btn: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        choose_class_btn = false
        choose_assignment_btn = false
        choose_task_btn = false
        setUpProfile()
        
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
        
        choose_class_btn_text = choose_color_for_class_btn.currentTitle
        choose_task_btn_text = choose_color_for_task_btn.currentTitle
        choose_assignment_btn_text = choose_color_for_assignment_btn.currentTitle
        
        
        classPickedColor = choose_class_btn_text
        assignmentPickedColor = choose_assignment_btn_text
        taskPickedColor = choose_task_btn_text
        
        task_num_stepper.isHidden = true
        notification_hour.isEnabled = false
        choose_color_for_class_btn.isEnabled = false
        choose_theme_btn.isEnabled = false
        choose_color_for_task_btn.isEnabled = false
        choose_color_for_assignment_btn.isEnabled = false
        done_btn.isHidden = true
        task_num_stepper.maximumValue = 9
        task_num_stepper.minimumValue = 1
        task_num_stepper.value = 3.0
        
    }
    
    @IBAction func task_number_stepper_action(_ sender: Any) {
        task_num_label.text = String(task_num_stepper.value)
    }
    
    @IBAction func choose_color_for_class_action(_ sender: Any) {
        choose_class_btn = true
        chooseColor(from: "class")
        self.choose_color_for_class_btn.setTitle(classPickedColor, for: .normal)
    }
    
    @IBAction func choose_color_for_assignment_action(_ sender: Any) {
        choose_assignment_btn = true
        chooseColor(from: "assignment")
        self.choose_color_for_assignment_btn.setTitle(assignmentPickedColor, for: .normal)
    }
    
    @IBAction func choose_color_for_task_action(_ sender: Any) {
        choose_task_btn = true
        chooseColor(from: "task")
        self.choose_color_for_task_btn.setTitle(taskPickedColor, for: .normal)
    }
    
    @IBAction func choose_theme(_ sender: Any) {
        
    }
    
    func chooseColor(from: String) {
        let popChooseColorView = UIStoryboard(name: "HomePage", bundle: nil).instantiateViewController(withIdentifier: "ChooseColor") as! ChooseColorViewController
        
        askfrom = from
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
        self.choose_color_for_class_btn.setTitle("Choose Class Color", for: .normal)
        self.choose_color_for_assignment_btn.setTitle("Choose Assignment Color", for: .normal)
        self.choose_color_for_task_btn.setTitle("Choose Task Color", for: .normal)
        self.choose_theme_btn.setTitle("Choose Theme", for: .normal)
    }
    
    @IBAction func done_action(_ sender: Any) {
        task_num_stepper.isHidden = true
        notification_hour.isEnabled = false
        choose_color_for_class_btn.isEnabled = false
        choose_theme_btn.isEnabled = false
        choose_color_for_task_btn.isEnabled = false
        choose_color_for_assignment_btn.isEnabled = false
        done_btn.isHidden = true
        
        if !choose_class_btn {
            choose_color_for_class_btn.setTitle(choose_class_btn_text, for: .normal)
        }
        
        if !choose_assignment_btn {
            choose_color_for_assignment_btn.setTitle(choose_assignment_btn_text, for: .normal)
        }
        
        if !choose_task_btn {
            choose_color_for_task_btn.setTitle(choose_assignment_btn_text, for: .normal)
        }
        
        classPickedColor = choose_color_for_class_btn.currentTitle
        assignmentPickedColor = choose_color_for_task_btn.currentTitle
        taskPickedColor = choose_color_for_assignment_btn.currentTitle
    }
}
