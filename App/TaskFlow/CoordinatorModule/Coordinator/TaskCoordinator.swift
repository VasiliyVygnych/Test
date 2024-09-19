//
//  TaskCoordinator.swift
//  Task List
//
//  Created by Vasiliy Vygnych on 26.08.2024.
//

import UIKit

class TaskCoordinator: TaskCoordinatorProtocol {
    
    var navigationController: UINavigationController?
    var assembler: TaskBuilderProtocol
    
    init(navigationController: UINavigationController?,
         assembler: TaskBuilderProtocol = TaskBuilder()) {
        self.navigationController = navigationController
        self.assembler = assembler
    }
    
    func initial() {
        if let navigationController = navigationController {
            let controller = assembler.createBaseController(coordinator: self)
            navigationController.viewControllers = [controller]
        }
    }
    func createAddTaskController(date: String?,
                                 delegate: BaseViewDelegate) {
        if let navigationController = navigationController {
            let controller = assembler.createAddTaskController(coordinator: self,
                                                         date: date,
                                                         delegate: delegate)
            navigationController.present(controller,
                                         animated: true)
        }
    }
    func createDetailViewController(model: TaskModel?,
                                    delegate: BaseViewDelegate) {
        if let navigationController = navigationController {
            let controller = assembler.createDetailViewController(coordinator: self,
                                                                  model: model,
                                                                  delegate: delegate)
            navigationController.pushViewController(controller,
                                                    animated: false)
        }
    }
}
