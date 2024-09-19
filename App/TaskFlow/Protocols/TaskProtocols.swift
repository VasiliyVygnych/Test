//
//  TaskProtocols.swift
//  Task List
//
//  Created by Vasiliy Vygnych on 26.08.2024.
//

import UIKit
import CoreData

protocol BaseViewDelegate: AnyObject {
    func reloadView()
    func showTask(date: String)
}

protocol BaseViewProtocol {
    var presenter: TaskPresenterProtocol? { get set }
    func getData(_ data: [TaskModel]?)
}

protocol TaskPresenterProtocol {
    var view: BaseViewProtocol? { get set }
    var interactor: TaskInteractorInputProtocol? { get set }
    var coordinator: TaskCoordinatorProtocol? { get set }

    func viewDidLoad()
    func fetchData()
    func remove(_ id: Int)
    func removeAll()
    func edirOrAddTask(_ status: addStatus,
                       id: Int?,
                       name: String?,
                       description: String?,
                       dateOfCreation: String?)
    func openAddTaskController(date: String?)
    func showDetailViewController(model: TaskModel?)
    func clickToAnimate(view: UIView)
    func showTasksToday(date: String)
    func saveCompleted(id: Int,
                       status: Bool)
}

protocol TaskInteractorInputProtocol {
    var presenter: TaskInteractorOutputProtocol? { get set }
    var network: NetworkServiseProtocol? { get set }
    var coreData: CoreManagerProtocol? { get set }
    var delegate: BaseViewDelegate? { get set }
    
    func removeAllData()
    func editTaskModel(_ status: addStatus,
                       id: Int?,
                       name: String?,
                       description: String?,
                       dateOfCreation: String?)
    func assignВata()
    func removeItems(_ id: Int)
    func showTask(date: String)
    func editCompleted(id: Int,
                       status: Bool)
    func fetchNetworkData()
}

protocol TaskInteractorOutputProtocol {
    func didRetrieveModel(_ data: [TaskModel]?)
    
}
