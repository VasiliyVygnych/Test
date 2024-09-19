//
//  NteworkProtocols.swift
//  Task List
//
//  Created by Vasiliy Vygnych on 26.08.2024.
//

import Foundation

protocol NetworkServiseProtocol {
    func fetchData(completion: @escaping (NetworkTask?) -> Void)
}
