//
//  CoreManager.swift
//  Task List
//
//  Created by Vasiliy Vygnych on 26.08.2024.
//

import CoreData
import UIKit

final class CoreManager: CoreManagerProtocol {
    
    var delegat: AppDelegate
    var context: NSManagedObjectContext
    
    init() {
        delegat = UIApplication.shared.delegate as! AppDelegate
        context = delegat.persistentContainer.viewContext
    }
   
    func removeModel() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskModel")
        do {
            let data = try? context.fetch(fetchRequest) as? [TaskModel]
            data?.forEach({ context.delete($0) })
        }
        delegat.saveContext()
    }
    
    func removeModell(id: Int) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskModel")
        do {
            guard let data = try? context.fetch(fetchRequest) as? [TaskModel],
                  let mark = data.first(where: { $0.id == id }) else { return }
            context.delete(mark)
        }
        delegat.saveContext()
    }
    func setModel(_ sort: Bool) -> [TaskModel] {
        let sortDescriptor = NSSortDescriptor(key: "id",
                                              ascending: sort)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskModel")
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            return try context.fetch(fetchRequest) as! [TaskModel]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    func addModel(name: String?,
                  description: String?,
                  dateOfCreation: String?) {
        guard let nameEntity = NSEntityDescription.entity(forEntityName: "TaskModel",
                                                          in: context) else { return }
        let model = TaskModel(entity: nameEntity,
                                    insertInto: context)
        let data = setModel(true)
        model.id = Int16(data.count - 1)
        model.dateOfCreation = dateOfCreation
        model.todoName = name
        model.todoDescription = description
        model.completed = false
        delegat.saveContext()
    }
    func addModel(with id: Int,
                  name: String?,
                  description: String?,
                  dateOfCreation: String?) {
        guard let nameEntity = NSEntityDescription.entity(forEntityName: "TaskModel",
                                                          in: context) else { return }
        let model = TaskModel(entity: nameEntity,
                                    insertInto: context)
        model.id = Int16(id)
        model.dateOfCreation = dateOfCreation
        model.todoName = name
        model.todoDescription = description
        model.completed = false
        delegat.saveContext()
    }
    func fetchTask(weakday day: String,
                   sort: Bool) -> [TaskModel] {
        let sortDescriptor = NSSortDescriptor(key: "id",
                                              ascending: sort)
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskModel")
        fetchRequest.predicate = NSPredicate(format: "dateOfCreation CONTAINS[cd] %@", day)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            return try context.fetch(fetchRequest) as! [TaskModel]
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    func completedTask(with id: Int,
                       completed: Bool) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskModel")
        do {
           guard let data = try? context.fetch(fetchRequest) as? [TaskModel],
                 let attribute = data.first(where: { $0.id == id }) else { return }
            attribute.completed = completed
        }
        delegat.saveContext()
    }
    func editModel(with id: Int,
                   name: String?,
                   description: String?,
                   dateOfCreation: String?) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TaskModel")
        do {
           guard let data = try? context.fetch(fetchRequest) as? [TaskModel],
                 let attribute = data.first(where: { $0.id == id }) else { return }
            attribute.dateOfCreation = dateOfCreation
            attribute.todoName = name
            attribute.todoDescription = description
        }
        delegat.saveContext()
    }
}
