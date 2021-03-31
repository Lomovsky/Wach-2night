//
//  NetworkManager.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 11.12.2020.
//

import Foundation
import Alamofire


final class NetworkManager {
    
     func fetchCurrentData<DataModel: Codable>(withURL url: String, dataModel: DataModel.Type, completion: @escaping (Result<DataModel, Error>) -> Void) {
        
        let downloadQueue = DispatchQueue(label: "networkManagerQueue", qos: .utility)

        guard let url = URL(string: url) else { return }
        downloadQueue.async {
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
        print("\(self) was deallocated")
    }
}
