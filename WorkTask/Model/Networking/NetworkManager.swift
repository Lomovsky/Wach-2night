//
//  NetworkManager.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 11.12.2020.
//

import Foundation
import Alamofire


class NetworkManager {
    
    static func fetchCurrentData(withURL url: String, completion: @escaping (Result<FilmResponse, Error>) -> Void) {
        
        guard let url = URL(string: url) else { return }
        let request = AF.request(url)
        request.responseJSON { (response) in
            if let error = response.error {
                completion(.failure(error))
            } else {
                guard let JSONData = response.data, let JSONResponse = response.response else { return }
                print(JSONResponse)
                
                do {
                    let films = try JSONDecoder().decode(FilmResponse.self, from: JSONData)
                    completion(.success(films))
                } catch let error as NSError {
                    print(error)
                }
            }
        }
    }
}
