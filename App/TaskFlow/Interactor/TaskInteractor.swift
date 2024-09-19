//
//  TaskInteractor.swift
//  Task List
//
//  Created by Vasiliy Vygnych on 26.08.2024.
//

import Foundation

class TaskInteractor: TaskInteractorInputProtocol {
    
    var presenter: TaskInteractorOutputProtocol?
    var network: NetworkServiseProtocol?
    var coreData: CoreManagerProtocol?
    weak var delegate: BaseViewDelegate?
    
    func removeAllData() {
        DispatchQueue.global(qos: .background).sync {
            self.coreData?.removeModel()
        }
    }
    func editTaskModel(_ status: addStatus,
                       id: Int?,
                       name: String?,
                       description: String?,
                       dateOfCreation: String?) {
        switch status {
        case .add:
            coreData?.addModel(name: name,
                               description: description,
                               dateOfCreation: dateOfCreation)
        case .edit:
            guard let id = id else { return }
            coreData?.editModel(with: id, 
                                name: name,
                                description: description,
                                dateOfCreation: dateOfCreation)
        }
    }
    func assignВata() {
        let data = coreData?.setModel(false)
        presenter?.didRetrieveModel(data)
    }
    func removeItems(_ id: Int) {
        DispatchQueue.global(qos: .background).sync {
            self.coreData?.removeModell(id: id)
        }
    }
    func showTask(date: String) {
        let data = coreData?.fetchTask(weakday: date,
                                       sort: false)
        presenter?.didRetrieveModel(data)
    }
    func editCompleted(id: Int,
                       status: Bool) {
        coreData?.completedTask(with: id,
                                completed: status)
    }
    func fetchNetworkData() {
        network?.fetchData(completion: { [weak self] model in
            DispatchQueue.main.async {
                guard let self = self else { return }
                guard let model = model?.todos else { return }
                let formatter = DateFormatter()
                formatter.dateFormat = "dd.MM.yyyy"
                model.enumerated().forEach { index, data in
                    self.coreData?.addModel(with: index,
                                            name: "task № \(data.id)",
                                            description: data.todo,
                                            dateOfCreation: formatter.string(from: Date()))
                }
                self.delegate?.reloadView()
            }
        })
    }
}
