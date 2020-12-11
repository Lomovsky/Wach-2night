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
            guard let data = data else {return}
            DispatchQueue.main.async {
                print(data)
                self.parseJSON(withData: data)
            }

            
        }
        task.resume()
    }
    
    func parseJSON(withData data: Data) {
        let decoder = JSONDecoder()
        do {
            let currentFilmData = try decoder.decode(WelcomeElement.self, from: data)
            print(currentFilmData)
        } catch let error as NSError {
            print(error)
        }
    }
}
