//
//  NetworkManager.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 11.12.2020.
//

import Foundation


extension ViewController {
 
    func fetchCurrentData() {
        let urlString = "https://kaverin-ddb.firebaseio.com/dbs/movies.json?print=pretty"
        guard let url = URL(string: urlString) else {return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) {data, response, error in
            guard let response = response,
                  let data = data
            else {return}
                            print(response)
                print("The data is \(data)")
            
                do {
                    self.films = try JSONDecoder().decode([WelcomeElement].self, from: data)
                    print(self.films.count)
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                                        
                } catch let error as NSError {
                    print(error)
                }
            
            

            
        }
        task.resume()
    }

   
}
