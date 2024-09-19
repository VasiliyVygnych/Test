//
//  TaskPresenter.swift
//  Task List
//
//  Created by Vasiliy Vygnych on 26.08.2024.
//

import UIKit

class TaskPresenter: TaskPresenterProtocol {

    var view: BaseViewProtocol?
    var interactor: TaskInteractorInputProtocol?
    var coordinator: TaskCoordinatorProtocol?
    private var defaults = UserDefaults.standard

    func viewDidLoad() {
        interactor?.assignВata()
        interactor?.delegate = self
    }
    func fetchData() {
        interactor?.fetchNetworkData()
    }
    func edirOrAddTask(_ status: addStatus,
                       id: Int?,
                       name: String?,
                       description: String?,
                       dateOfCreation: String?) {
        interactor?.editTaskModel(status,
                                  id: id,
                                  name: name,
                                  description: description,
                                  dateOfCreation: dateOfCreation)
    }
    func showTasksToday(date: String) {
        interactor?.showTask(date: date)
    }
    func remove(_ id: Int) {
        interactor?.removeItems(id)
        interactor?.assignВata()
    }
    func removeAll() {
        interactor?.removeAllData()
    }
    func openAddTaskController(date: String?) {
        coordinator?.createAddTaskController(date: date,
                                             delegate: self)
    }
    func showDetailViewController(model: TaskModel?) {
        coordinator?.createDetailViewController(model: model,
                                                delegate: self)
    }
    func saveCompleted(id: Int,
                       status: Bool) {
        interactor?.editCompleted(id: id,
                                  status: status)
    }
    func clickToAnimate(view: UIView) {
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
            view.transform = CGAffineTransform(scaleX: 0.95,
                                               y: 0.95)
        }, completion: { finished in
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: .curveEaseOut,
                           animations: {
                view.transform = CGAffineTransform(scaleX: 1,
                                                   y: 1)
            })
        })
    }
}
extension TaskPresenter: TaskInteractorOutputProtocol {
    func didRetrieveModel(_ data: [TaskModel]?) {
        view?.getData(data)
    }
}
extension TaskPresenter: BaseViewDelegate {
    func reloadView() {
        viewDidLoad()
    }
    func showTask(date: String) {
        showTasksToday(date: date)
    }
}
