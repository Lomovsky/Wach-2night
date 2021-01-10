//
//  CoreDataManager.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 08.01.2021.
//

import UIKit
import CoreData

extension ViewController {
    
    
    public func save(_ filmTitle: String, filmOriginalTitle: String, filmPoster: Data) {
        //создаем сущность в качестве проводника в экземпляр нашей сущности в хранилище
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "CurrentFilm", in: managedContext) else { return }
        let film = NSManagedObject(entity: entityDescription, insertInto: managedContext) as! CurrentFilm
        
        film.originalTitle = filmOriginalTitle
        film.title = filmTitle
        film.poster = filmPoster
        
        do {
            try managedContext.save()
            films.append(film)
//            self.collectionView.insertItems(at: [IndexPath(row: films.count - 1, section: 0)])
        } catch let error as NSError {
            print(error)
        }
    }
    
    public func fetchData() {
        //запрос выборки данных из базы всех значений по ключу Task
        let fetchRequest: NSFetchRequest<CurrentFilm> = CurrentFilm.fetchRequest()
        
        do {
            try films = managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print(error)
        }
    }
}
