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
    
    @IBOutlet weak var user_name: UILabel!

    @IBOutlet weak var email_address: UILabel!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var edit_password: UIButton!
    
    @IBOutlet weak var logout_btn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logout_btn.layer.cornerRadius = 5
        logout_btn.layer.borderWidth = 1
        logout_btn.layer.borderColor = UIColor.lightGray.cgColor
        user_name.text = CoreDataController().getFullUserName()
        email_address.text = CoreDataController().getEmailAddress()
        password.text = CoreDataController().getPassword()
        password.isEnabled = false
    }
    
    @IBAction func changePassword(_ sender: Any){
        if edit_password.imageView?.image == #imageLiteral(resourceName: "lock_icon") {
            edit_password.setImage(#imageLiteral(resourceName: "unlock_icon"), for: .normal)
            password.isEnabled = true
            password.placeholder = "Input your new password."
        }
        else if edit_password.imageView?.image == #imageLiteral(resourceName: "unlock_icon"){
            password.placeholder = ""
            password.isEnabled = false
            edit_password.setImage(#imageLiteral(resourceName: "lock_icon"), for: .normal)
            CoreDataController().changePassword(email: email_address.text!, newPassword: password.text!)
            let alertController = UIAlertController(title: "Change Password", message:
                "You password has been reset.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
   
    @IBAction func log_out(_ sender: Any) {
        CoreDataController().resetLoginStatus(email_address: email_address.text!)
        let mainpage = UIStoryboard(name: "SignupandLogin", bundle: nil)
        let vc = mainpage.instantiateInitialViewController()
        show(vc!, sender: self)
    }
}
