//
//  Setting+CoreDataProperties.swift
//  InstaPlan
//
//  Created by 康壮伟 on 4/25/17.
//  Copyright © 2017 Zhuangwei Kang. All rights reserved.
//

import Foundation
import CoreData


extension Setting {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Setting> {
        return NSFetchRequest<Setting>(entityName: "Setting")
    }

    @NSManaged public var assignment_color: String?
    @NSManaged public var class_color: String?
    @NSManaged public var homepage_task_num: Int16
    @NSManaged public var notification: Int16
    @NSManaged public var task_color: String?
    @NSManaged public var theme: String?
    @NSManaged public var user: InstaPlanUser?

}
