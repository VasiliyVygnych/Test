//
//  CoordinatorProtocols.swift
//  Task List
//
//  Created by Vasiliy Vygnych on 26.08.2024.
//

import Foundation
import UIKit

protocol TaskBuilderProtocol {
    func createBaseController(coordinator: TaskCoordinatorProtocol) -> UIViewController
    func createAddTaskController(coordinator: TaskCoordinatorProtocol,
                                 date: String?,
                                 delegate: BaseViewDelegate) -> UIViewController
    func createDetailViewController(coordinator: TaskCoordinatorProtocol,
                                    model: TaskModel?,
                                    delegate: BaseViewDelegate) -> UIViewController
}

protocol TaskCoordinatorProtocol {
    func initial()
    func createAddTaskController(date: String?,
                                 delegate: BaseViewDelegate)
    func createDetailViewController(model: TaskModel?,
                                    delegate: BaseViewDelegate)
}
