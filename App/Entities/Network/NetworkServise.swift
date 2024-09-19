//
//  NetworkServise.swift
//  Task List
//
//  Created by Vasiliy Vygnych on 26.08.2024.
//

import UIKit

class NetworkServise: NetworkServiseProtocol {
    
    func request(urlString: URL,
                 completion: @escaping ( Result <Data, Error>) -> Void) {
        let request = URLRequest(url: urlString)
        URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
        }.resume()
    }
func fetchData(completion: @escaping (NetworkTask?) -> Void) {
        let urlString = URL(string: "https://dummyjson.com/todos")
        guard let url = urlString else { return }
        request(urlString: url) { [weak self] (result)  in
            guard self != nil else { return }
            switch result {
            case .success(let data):
                do {
                    let model =  try JSONDecoder().decode(NetworkTask.self,
                                                          from: data)
                    
                    completion(model)
                } catch let jsonError {
                    print("ERROR", jsonError)
                    completion(nil)
                }
            case .failure(let error):
                print("ERROR DATA \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
