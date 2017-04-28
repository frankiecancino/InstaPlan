//
//  CustomNotes+CoreDataProperties.swift
//  InstaPlan
//
//  Created by 康壮伟 on 4/28/17.
//  Copyright © 2017 Zhuangwei Kang. All rights reserved.
//

import Foundation
import CoreData


extension CustomNotes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CustomNotes> {
        return NSFetchRequest<CustomNotes>(entityName: "CustomNotes")
    }

    @NSManaged public var notes: String?
    @NSManaged public var note_name: String?
    @NSManaged public var user: InstaPlanUser?

}
