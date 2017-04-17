//
//  CoreDataController.swift
//  InstaPlan
//
//  Created by 康壮伟 on 4/13/17.
//  Copyright © 2017 Zhuangwei Kang. All rights reserved.
//

import UIKit
import CoreData

var currentUserName: String!
var currentUserEmail: String!

class CoreDataController: NSObject {
    
    
    
    //Get context
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    ///
    ///Store user information
    ///
    func storeUser(user_name: String, email_address: String, password: String) {
        let context = getContext()
        
        //define the entity
        let entity = NSEntityDescription.entity(forEntityName: "InstaPlanUser", in: context)
        
        let user = NSManagedObject(entity: entity!, insertInto: context)
        
        currentUserName = user_name
        
        user.setValue(user_name, forKey: "user_name")
        user.setValue(email_address, forKey: "email_address")
        user.setValue(password, forKey: "password")
        user.setValue(true, forKey: "login_status")
        
        do{
            try context.save()
            
        }catch{
            print(error)
        }
    }
    
    ///
    ///Sign up input check
    ///prameter: user input email address
    ///return false if the email address has existed in CoreData
    ///
    func signupCheck(email_address: String) -> Bool {
        currentUserEmail = email_address
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "InstaPlanUser")
        do{
            let searchResuls = try getContext().fetch(fetchRequest)
            for item in (searchResuls as! [NSManagedObject]){
                let email = item.value(forKey: "email_address") as! String
                print("This is the email address: ", email)
                if email_address == email {
                    currentUserName = item.value(forKey: "user_name") as! String
                    return false
                }
            }
        }catch{
            print(error)
            //return true
        }
        return true
    }
    
    ///
    ///Log in check
    ///prameter: user input email address and password
    ///return false is no match user in core data
    ///
    func loginCheck(email_address: String, password: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "InstaPlanUser")
        do{
            let searchResuls = try getContext().fetch(fetchRequest)
            for item in (searchResuls as! [NSManagedObject]){
                let email = item.value(forKey: "email_address") as! String
                let password = item.value(forKey: "password") as! String
                if email == email_address && password == password {
                    currentUserEmail = email_address
                    currentUserName = item.value(forKey: "user_name") as! String
                    return true
                }
            }
        }catch{
            print(error)
            return false
        }
        return false
    }
    
    ///
    ///Rest user login status
    ///prameter: user email address
    ///
    func resetLoginStatus(email_address: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "InstaPlanUser")
        do {
            let searchResuls = try getContext().fetch(fetchRequest)
            for item in (searchResuls as! [NSManagedObject]){
                if email_address == item.value(forKeyPath: "email_address") as! String{
                    item.setValue(false, forKey: "login_status")
                    let context = getContext()
                    try context.save()
                }
            }
        } catch {
            print("reset login status failed:", error)
        }
    }
    
    ///
    ///Get user username
    ///
    func getUserName() -> String {
        return String(describing: currentUserName.characters.first!)
    }
    
    ///
    ///Get full user name
    ///
    func getFullUserName() -> String {
        return currentUserName
    }

    ///
    ///Get full user email
    ///
    func getEmailAddress() -> String {
        return currentUserEmail
    }
}
