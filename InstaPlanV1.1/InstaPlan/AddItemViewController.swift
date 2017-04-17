//
//  AddItemViewController.swift
//  InstaPlan
//
//  Created by 康壮伟 on 4/15/17.
//  Copyright © 2017 Zhuangwei Kang. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }
 
    
    
    @IBAction func closePopView(_ sender: Any) {
        self.view.removeFromSuperview()
        
    }
   
}
