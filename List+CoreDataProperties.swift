//
//  List+CoreDataProperties.swift
//  HikingProject
//
//  Created by Jesse viau on 2023-10-11.
//
//

import Foundation
import CoreData


extension List {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "List")
    }

    @NSManaged public var listName: String?
    @NSManaged public var tasks: TaskItem?

}

extension List : Identifiable {

}
