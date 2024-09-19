//
//  TaskModel.swift
//  Task List
//
//  Created by Vasiliy Vygnych on 26.08.2024.
//

import Foundation
import CoreData

@objc(TaskModel)
public class TaskModel: NSManagedObject {}
extension TaskModel {
    @NSManaged public var id: Int16
    @NSManaged public var todoName: String?
    @NSManaged public var dateOfCreation: String?
    @NSManaged public var todoDescription: String?
    @NSManaged public var completed: Bool
}
extension TaskModel : Identifiable {}
