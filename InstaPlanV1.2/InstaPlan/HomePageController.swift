//
//  HomePageController.swift
//  InstaPlan
//
//  Created by 康壮伟 on 4/14/17.
//  Copyright © 2017 Zhuangwei Kang. All rights reserved.
//

import UIKit

var flag: Bool = false

class HomePageController: UITabBarController {

    @IBOutlet weak var tabs: UITabBar!
    
    @IBOutlet weak var plusBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func addItemAction(_ sender: Any) {
        if !flag {
            flag = true
            let popAddChoicesView = UIStoryboard(name: "HomePage", bundle: nil).instantiateViewController(withIdentifier: "AddChoicesView") as! UINavigationController
            
            self.addChildViewController(popAddChoicesView)
            popAddChoicesView.view.frame = self.view.frame
            self.view.addSubview(popAddChoicesView.view)
            popAddChoicesView.didMove(toParentViewController: self)
        }
        else{
            let alert = UIAlertController(title: "Plus button alert", message: "Please complete your current operation.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    

}