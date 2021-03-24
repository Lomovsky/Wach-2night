//
//  CoreDataManager.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 08.01.2021.
//

import UIKit
import CoreData

final public class CoreDataManager {
    
    static var films: [CurrentFilm] = []
    static var genres: [Genre] = []
    static var favouriteFilms: [FavouriteFilm] = [] {
        didSet {
            let viewModel = SuggestionsViewViewModel()
            if favouriteFilms.isEmpty {
                viewModel.favoriteFilmsArrayIsEmpty = true
            } else {
                viewModel.favoriteFilmsArrayIsEmpty = false
            }
        }
    }
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: Saving funcs
    func saveFilms(_ filmTitle: String, filmOriginalTitle: String, filmPoster: Data, releaseDate: String, overview: String, rating: Float) {
        
            self.managedContext.perform { [weak self] in
                guard let self = self else { return }
                
                guard let entityDescription = NSEntityDescription.entity(forEntityName: "CurrentFilm", in: self.managedContext) else { return }
                
                let film = NSManagedObject(entity: entityDescription, insertInto: self.managedContext) as! CurrentFilm
                film.title = filmTitle
                film.originalTitle = filmOriginalTitle
                film.poster = filmPoster
                film.releaseDate = releaseDate
                film.overview = overview
                film.rating = rating
                
                do {
                    try self.managedContext.save()
                    CoreDataManager.films.append(film)
                } catch let error as NSError {
                    print(error)
                }
            }
        

    }
    
    func saveGenres(_ genreID: Int, genreName: String) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Genre", in: managedContext) else { return }
        
        let genre = NSManagedObject(entity: entityDescription, insertInto: managedContext) as! Genre
        genre.id = Int32(genreID)
        genre.name = genreName
        
        do {
            try managedContext.save()
            CoreDataManager.genres.append(genre)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func saveFavouriteFilm (_ filmTitle: String, filmOriginalTitle: String, filmRating: Float, filmOverview: String, filmPoster: Data) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "FavouriteFilm", in: managedContext) else { return }
        
        let favouriteFilm = NSManagedObject(entity: entityDescription, insertInto: managedContext) as! FavouriteFilm
        favouriteFilm.title = filmTitle
        favouriteFilm.originalTitle = filmOriginalTitle
        favouriteFilm.overview = filmOverview
        favouriteFilm.rating = filmRating
        favouriteFilm.poster = filmPoster
        
        do {
            try managedContext.save()
            CoreDataManager.favouriteFilms.append(favouriteFilm)
        } catch let error as NSError {
            print(error)
        }
    }
    
    //MARK: Fetching methods -
    func fetchFilmsData() {
    }
    
    func fetchGenresData() {
        let fetchRequest: NSFetchRequest<Genre> = Genre.fetchRequest()
        
        do {
            try CoreDataManager.genres = managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func fetchFavouriteFilms() {
        let fetchRequest: NSFetchRequest<FavouriteFilm> = FavouriteFilm.fetchRequest()
        
        do {
            try CoreDataManager.favouriteFilms = managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
    //MARK: Deliting methods -
    
    func deleteAllData() {
        let fetchRequest: NSFetchRequest<CurrentFilm> = CurrentFilm.fetchRequest()
        let genreFetchRequest: NSFetchRequest<Genre> = Genre.fetchRequest()
        fetchRequest.includesPropertyValues = false
        
        do {
            let items = try managedContext.fetch(fetchRequest) as [NSManagedObject]
            for item in items {
                managedContext.delete(item)
            }
            try managedContext.save()
            CoreDataManager.films.removeAll()
            CoreDataManager.genres.removeAll()
            
        } catch let error as NSError {
            print(error)
        }
        
        do {
            let genreItems = try managedContext.fetch(genreFetchRequest) as [NSManagedObject]
            for genreItem in genreItems {
                managedContext.delete(genreItem)
            }
            try managedContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    func deleteAllDataFromFavourites() {
        let fetchRequest: NSFetchRequest<FavouriteFilm> = FavouriteFilm.fetchRequest()
        fetchRequest.includesPropertyValues = false
        
        do {
            let favFilms = try managedContext.fetch(fetchRequest) as [NSManagedObject]
            for film in favFilms {
                managedContext.delete(film)
            }
            try managedContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    deinit {
        print("CoreData manager was dealocated")
    }
}
