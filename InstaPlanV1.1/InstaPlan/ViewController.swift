//
//  ViewController.swift
//  InstaPlan
//
//  Created by 康壮伟 on 4/9/17.
//  Copyright © 2017 Zhuangwei Kang. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController, BWWalkthroughViewControllerDelegate {


    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let userDefaults = UserDefaults.standard
        
        if !userDefaults.bool(forKey: "walkthroughPresented") {
            
            showWalkthrough()
            
            userDefaults.set(true, forKey: "walkthroughPresented")
            userDefaults.synchronize()
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showWalkthrough(){
        
        // Get view controllers and build the walkthrough
        let stb = UIStoryboard(name: "Walkthrough", bundle: nil)
        let walkthrough = stb.instantiateViewController(withIdentifier: "welcome") as! BWWalkthroughViewController
        let page_zero = stb.instantiateViewController(withIdentifier: "welcome0")
        let page_one = stb.instantiateViewController(withIdentifier: "welcome1")
        let page_two = stb.instantiateViewController(withIdentifier: "welcome2")
        let page_three = stb.instantiateViewController(withIdentifier: "welcome3")
        
        // Attach the pages to the master
        walkthrough.delegate = self
        walkthrough.add(viewController:page_one)
        walkthrough.add(viewController:page_two)
        walkthrough.add(viewController:page_three)
        walkthrough.add(viewController:page_zero)
        
        self.present(walkthrough, animated: true, completion: nil)
    }
    
    /*
    func walkthroughCloseButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
     */
}

