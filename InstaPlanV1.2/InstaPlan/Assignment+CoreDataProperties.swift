//
//  Assignment+CoreDataProperties.swift
//  InstaPlan
//
//  Created by 康壮伟 on 4/25/17.
//  Copyright © 2017 Zhuangwei Kang. All rights reserved.
//

import Foundation
import CoreData


extension Assignment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Assignment> {
        return NSFetchRequest<Assignment>(entityName: "Assignment")
    }

    @NSManaged public var additional_info: String?
    @NSManaged public var assignment_name: String?
    @NSManaged public var class_name: String?
    @NSManaged public var due_date: NSDate?
    @NSManaged public var priority: Int16
    @NSManaged public var remind_time: Int16
    @NSManaged public var user: InstaPlanUser?

}
