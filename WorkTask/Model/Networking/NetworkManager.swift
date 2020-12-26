//
//  NetworkManager.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 11.12.2020.
//

import Foundation


class NetworkManager {
 
    static func fetchCurrentData(withURL url: String, completion: @escaping (Result<FilmResponse, Error>) -> Void) {
        guard let url = URL(string: url) else {return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) {data, response, error in
        DispatchQueue.main.async {
            if let error = error {
                print(error)
                completion(.failure(error))
                return
            } else {
                guard let response = response,
                      let data = data
                else {return}
                print(response)
                
                do{
                    let films = try JSONDecoder().decode(FilmResponse.self, from: data)
                    completion(.success(films))
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
         
            
            
          }
    
      }
        task.resume()
    }
}