//
//  CoreDataManager.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 08.01.2021.
//

import UIKit
import CoreData

class CoreDataManager {
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    public func save(_ filmTitle: String, filmOriginalTitle: String, filmPoster: Data, releaseDate: String, overview: String, rating: Float) {
        
        //создаем сущность в качестве проводника в экземпляр нашей сущности в хранилище
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "CurrentFilm", in: managedContext) else { return }
        let film = NSManagedObject(entity: entityDescription, insertInto: managedContext) as! CurrentFilm
        film.title = filmTitle
        film.originalTitle = filmOriginalTitle
        film.poster = filmPoster
        film.releaseDate = releaseDate
        film.overview = overview
        film.rating = rating
        
        do {
            try managedContext.save()
            ViewController.films.append(film)
        } catch let error as NSError {
            print(error)
        }
    }
    
    public func fetchData() {
        //запрос выборки данных из базы всех значений по ключу Task
        let fetchRequest: NSFetchRequest<CurrentFilm> = CurrentFilm.fetchRequest()
        
        do {
            try ViewController.films = managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
    public func deleteAllData() {
        let fetchRequest: NSFetchRequest<CurrentFilm> = CurrentFilm.fetchRequest()
        fetchRequest.includesPropertyValues = false
        do {
            let items = try managedContext.fetch(fetchRequest) as [NSManagedObject]
            for item in items {
                managedContext.delete(item)
            }
            try managedContext.save()

        } catch let error as NSError{
           print(error)
        }
        
    }
}
