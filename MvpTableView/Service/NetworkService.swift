//
//  Service.swift
//  MvpTableView
//
//  Created by Александр on 16.04.2022.
//

import UIKit
//Работа с сетью
protocol  NetworkServiceProtocol {
    func loadData<T : Decodable>(url : String ,complition: @escaping (Result<T?,Error>) -> Void)
}
class NetworkService : NetworkServiceProtocol {
    func loadData<T : Decodable>(url : String,complition: @escaping (Result<T?, Error>) -> Void) {
        guard let url = URL(string: url) else {return}
        URLSession.shared.dataTask(with: url) { data, _, error  in
            if let error = error {
                complition(.failure(error))
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data!)
                complition(.success(result))
            } catch {
                complition(.failure(error))
            }
        }.resume()
    }
}
