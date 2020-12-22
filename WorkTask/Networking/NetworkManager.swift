//
//  NetworkManager.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 11.12.2020.
//

import Foundation


class NetworkManager {
 
    static func fetchCurrentData(withURL url: String, completion: @escaping (_ data: Data)->()) {
        guard let url = URL(string: url) else {return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) {data, response, error in
            guard let response = response,
                  let data = data
            else {return}
                print(response)
                print("The data is \(data)")
            completion(data)
        }
        task.resume()
    }
}
