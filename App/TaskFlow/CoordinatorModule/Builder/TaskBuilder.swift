//
//  TaskBuilder.swift
//  Task List
//
//  Created by Vasiliy Vygnych on 26.08.2024.
//

import UIKit

class TaskBuilder: TaskBuilderProtocol {

    func createBaseController(coordinator: TaskCoordinatorProtocol) -> UIViewController {
        let controller = TaskBaseController()
        var presenter: TaskPresenterProtocol & TaskInteractorOutputProtocol = TaskPresenter()
        var interactor: TaskInteractorInputProtocol = TaskInteractor()
        let network: NetworkServiseProtocol = NetworkServise()
        let coreData: CoreManagerProtocol = CoreManager()
        
        let coordinator = coordinator
        controller.presenter = presenter
        presenter.view = controller
        presenter.interactor = interactor
        presenter.coordinator = coordinator
        interactor.presenter = presenter
        interactor.coreData = coreData
        interactor.network = network
        return controller
    }
    func createAddTaskController(coordinator: TaskCoordinatorProtocol,
                                 date: String?,
                                 delegate: BaseViewDelegate) -> UIViewController {
        let controller = AddTaskController()
        var presenter: TaskPresenterProtocol & TaskInteractorOutputProtocol = TaskPresenter()
        var interactor: TaskInteractorInputProtocol = TaskInteractor()
        let coreData: CoreManagerProtocol = CoreManager()
        let coordinator = coordinator
        controller.presenter = presenter
        controller.delegate = delegate
        controller.dateOfCreation = date
        presenter.interactor = interactor
        presenter.coordinator = coordinator
        interactor.coreData = coreData
        interactor.presenter = presenter
        return controller
    }
    func createDetailViewController(coordinator: TaskCoordinatorProtocol,
                                    model: TaskModel?,
                                    delegate: BaseViewDelegate) -> UIViewController {
        let controller = DetailViewController()
        var presenter: TaskPresenterProtocol & TaskInteractorOutputProtocol = TaskPresenter()
        var interactor: TaskInteractorInputProtocol = TaskInteractor()
        let coreData: CoreManagerProtocol = CoreManager()
        let coordinator = coordinator
        controller.presenter = presenter
        controller.model = model
        controller.delegate = delegate
        presenter.interactor = interactor
        presenter.coordinator = coordinator
        interactor.coreData = coreData
        interactor.presenter = presenter
        return controller
    }
}
