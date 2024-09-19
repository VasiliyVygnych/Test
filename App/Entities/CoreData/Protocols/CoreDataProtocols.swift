//
//  CoreDataProtocols.swift
//  Task List
//
//  Created by Vasiliy Vygnych on 26.08.2024.
//


import Foundation
import CoreData

protocol CoreManagerProtocol {
    var context: NSManagedObjectContext { get set }
    var delegat: AppDelegate { get set }
    
    func removeModel()
    func removeModell(id: Int)
    func addModel(name: String?,
                  description: String?,
                  dateOfCreation: String?)
    func addModel(with id: Int,
                  name: String?,
                  description: String?,
                  dateOfCreation: String?)
    func setModel(_ sort: Bool) -> [TaskModel]
    func fetchTask(weakday day: String,
                   sort: Bool) -> [TaskModel]
    func completedTask(with id: Int,
                       completed: Bool)
    func editModel(with id: Int,
                   name: String?,
                   description: String?,
                   dateOfCreation: String?)
}
