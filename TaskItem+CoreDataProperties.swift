//
//  TaskItem+CoreDataProperties.swift
//  HikingProject
//
//  Created by Jesse viau on 2023-10-11.
//
//

import Foundation
import CoreData


extension TaskItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskItem> {
        return NSFetchRequest<TaskItem>(entityName: "TaskItem")
    }

    @NSManaged public var taskName: String?
    @NSManaged public var taskList: List?

}

extension TaskItem : Identifiable {

}
