//
//  HomePageController.swift
//  InstaPlan
//
//  Created by 康壮伟 on 4/14/17.
//  Copyright © 2017 Zhuangwei Kang. All rights reserved.
//

import UIKit

class HomePageController: UITabBarController {

    @IBOutlet weak var tabs: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func addItemAction(_ sender: Any) {
        let popAddChoicesView = UIStoryboard(name: "HomePage", bundle: nil).instantiateViewController(withIdentifier: "AddChoicesView") as! AddItemViewController
        
        self.addChildViewController(popAddChoicesView)
        popAddChoicesView.view.frame = self.view.frame
        self.view.addSubview(popAddChoicesView.view)
        popAddChoicesView.didMove(toParentViewController: self)
        
    }
    

}
