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
    
    //MARK: Saving funcs
    public func saveFilms(_ filmTitle: String, filmOriginalTitle: String, filmPoster: Data, releaseDate: String, overview: String, rating: Float) {
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
            SuggestionsViewController.films.append(film)
        } catch let error as NSError {
            print(error)
        }
    }
    
    public func saveGenres(_ genreID: Int, genreName: String) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Genre", in: managedContext) else { return }
        
        let genre = NSManagedObject(entity: entityDescription, insertInto: managedContext) as! Genre
        genre.id = Int32(genreID)
        genre.name = genreName
        
        do {
            try managedContext.save()
            SuggestionsViewController.genres.append(genre)
        } catch let error as NSError {
            print(error)
        }
    }
    
    public func saveFavouriteFilm (_ filmTitle: String, filmOriginalTitle: String, filmRating: Float, filmOverview: String, filmPoster: Data) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "FavouriteFilm", in: managedContext) else { return }
        
        let favouriteFilm = NSManagedObject(entity: entityDescription, insertInto: managedContext) as! FavouriteFilm
        favouriteFilm.title = filmTitle
        favouriteFilm.originalTitle = filmOriginalTitle
        favouriteFilm.overview = filmOverview
        favouriteFilm.rating = filmRating
        favouriteFilm.poster = filmPoster
        
        do {
            try managedContext.save()
            SuggestionsViewController.favouriteFilms.append(favouriteFilm)
        } catch let error as NSError {
            print(error)
        }
    }
    
    //MARK: Fetching funcs
    public func fetchFilmsData() {
        let fetchRequest: NSFetchRequest<CurrentFilm> = CurrentFilm.fetchRequest()
        
        do {
            try SuggestionsViewController.films = managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
    public func fetchGenresData() {
        let fetchRequest: NSFetchRequest<Genre> = Genre.fetchRequest()
        
        do {
            try SuggestionsViewController.genres = managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
    public func fetchFavouriteFilms() {
        let fetchRequest: NSFetchRequest<FavouriteFilm> = FavouriteFilm.fetchRequest()
        
        do {
            try SuggestionsViewController.favouriteFilms = managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
    //MARK: Deliting funcs
    
    public func deleteAllData() {
        let fetchRequest: NSFetchRequest<CurrentFilm> = CurrentFilm.fetchRequest()
        let genreFetchRequest: NSFetchRequest<Genre> = Genre.fetchRequest()
        fetchRequest.includesPropertyValues = false
        
        do {
            let items = try managedContext.fetch(fetchRequest) as [NSManagedObject]
            for item in items {
                managedContext.delete(item)
            }
            try managedContext.save()
            
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
    
    public func deleteAllDataFromFavourites() {
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
