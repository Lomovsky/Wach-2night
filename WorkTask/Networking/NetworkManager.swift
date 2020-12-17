//
//  NetworkManager.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 11.12.2020.
//

import Foundation
struct NetworkManager {
    public  func fetchCurrentData() {
        let urlString = "https://kaverin-ddb.firebaseio.com/dbs/movies.json?print=pretty"
        guard let url = URL(string: urlString) else {return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) {data, response, error in
            guard let response = response,
                  let data = data
            else {return}
            DispatchQueue.main.async {
                print(response)
                print(data)
            
                do {
                    films = try JSONDecoder().decode(Welcome.self, from: data)
                    print(films)
                } catch let error as NSError {
                    print(error)
                }
            
            }

            
        }
        task.resume()
    }

   
}
