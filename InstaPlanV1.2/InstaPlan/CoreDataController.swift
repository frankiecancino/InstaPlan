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
var current_user: InstaPlanUser!

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
        
        let user = NSManagedObject(entity: entity!, insertInto: context) as! InstaPlanUser
        
        currentUserName = user_name
        current_user = user
        
        user.user_name = user_name
        user.email_address = email_address
        user.password = password
        user.login_status = true
        
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
                    current_user = item as! InstaPlanUser
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
                    current_user = item as! InstaPlanUser
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
    
    ///
    ///Store user profile settings
    ///
    func store_settings(task_num: Int16, notification: Int16, class_color: String, assignment_color: String, task_color: String) {
        
        let context = getContext()
        
        //define the entity
        let entity = NSEntityDescription.entity(forEntityName: "Setting", in: context)
        
        let settings = NSManagedObject(entity: entity!, insertInto: context) as! Setting
        
        settings.assignment_color = assignment_color
        settings.class_color = class_color
        settings.notification = notification
        settings.homepage_task_num = task_num
        settings.task_color = task_color
        settings.user = current_user
        
        do{
            try context.save()
            
        }catch{
            print(error)
        }
    }
    
    ///
    ///Store user class information
    ///
    func storeClass(class_name: String, class_time: String, class_color: String, class_day: String, class_end_date: NSDate?, instructor_ta_info: String, additional_info: String) {
        
        let context = getContext()
        
        //define the entity
        let entity = NSEntityDescription.entity(forEntityName: "Course", in: context)
        
        let course = NSManagedObject(entity: entity!, insertInto: context) as! Course
        
        course.class_color = class_color
        course.class_time = class_time
        course.class_day = class_day
        course.instructor_ta_info = instructor_ta_info
        course.aditional_info = additional_info
        course.class_end_date = class_end_date
        course.class_name = class_name
    
        course.user = current_user
        
        do{
            try context.save()
            
        }catch{
            print(error)
        }

    }
    
    ///
    ///Store custom notes
    ///
    func storeCustomNotes(custom_notes: String) {
        let context = getContext()
        
        //define the entity
        let entity = NSEntityDescription.entity(forEntityName: "CustomNotes", in: context)
        
        let notes = NSManagedObject(entity: entity!, insertInto: context) as! CustomNotes
        
        notes.notes = custom_notes
        
        notes.user = current_user
        
        do{
            try context.save()
        }catch{
            print(error)
        }
    }
}
