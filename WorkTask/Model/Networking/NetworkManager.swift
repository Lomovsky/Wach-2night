//
//  NetworkManager.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 11.12.2020.
//

import Foundation
import Alamofire


class NetworkManager {
    
    static func fetchCurrentData<DataModel: Codable>(withURL url: String, dataModel: DataModel.Type, completion: @escaping (Result<DataModel, Error>) -> Void) {
        
        guard let url = URL(string: url) else { return }
        DispatchQueue.global(qos: .utility).async {
            let request = AF.request(url)
            request.responseJSON { (response) in
                if let error = response.error {
                    completion(.failure(error))
                } else {
                    guard let JSONData = response.data, let JSONResponse = response.response else { return }
                    print(JSONResponse)
                    
                    do {
                        let decodedData = try JSONDecoder().decode(dataModel, from: JSONData)
                        completion(.success(decodedData))
                    } catch let error as NSError {
                        assertionFailure("NETWORK MANAGER FAILURE \(error), \(#line)")
                    }
                }
            }
        }
    }
    
    
    deinit {
        print("\(self) WAS Deallocated")
    }
}

//MARK: URLSession way to download data

///       guard let url = URL(string: url) else {return}
///       let session = URLSession(configuration: .default)
///        let task = session.dataTask(with: url) {data, response, error in
///        DispatchQueue.main.async {
///            if let error = error {
///                print(error)
///                completion(.failure(error))
///                return
///            } else {
///                guard let response = response,
///                      let data = data
///                else {return}
///                print(response)
///
///                do{
///                    let films = try JSONDecoder().decode(FilmResponse.self, from: data)
///                    completion(.success(films))
///                } catch let error as NSError {
///                    print(error.localizedDescription)
///                }
///            }
///
///          }
///
///      }
///        task.resume()
