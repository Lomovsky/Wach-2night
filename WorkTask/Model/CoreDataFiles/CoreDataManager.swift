//
//  CoreDataManager.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 08.01.2021.
//

import UIKit
import CoreData

enum ID {
    case genre
    case film
}

final public class CoreDataManager {
    let mainMOC = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let privateMOC = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.newBackgroundContext()
    var setOfIDs = Set<Int32>()
    var setOfGenres = Set<Int32>()
    
    //MARK: Saving funcs
    func checkForExistance(filmTitle: String, filmOriginalTitle: String, filmPoster: Data, releaseDate: String, overview: String, rating: Float, id: Int) {
        fetchIDs(id: .film)
        
        if setOfIDs.contains(Int32(id)) {
            print("Already exists")
        } else {
            saveFilms(filmTitle, filmOriginalTitle: filmOriginalTitle, filmPoster: filmPoster, releaseDate: releaseDate, overview: overview, rating: rating, id: id)
        }
    }
    
    func checkForGenreExistance(genreID: Int, genreName: String) {
        fetchIDs(id: .genre)
        
        if setOfGenres.contains(Int32(genreID)) {
            print("Genre already exists")
        } else {
            saveGenres(genreID, genreName: genreName)
        }
        
    }
    
    
    func saveFilms(_ filmTitle: String, filmOriginalTitle: String, filmPoster: Data, releaseDate: String, overview: String, rating: Float, id: Int) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "CurrentFilm", in: privateMOC) else { return }
        let film = NSManagedObject(entity: entityDescription, insertInto: privateMOC) as! CurrentFilm
        film.title = filmTitle
        film.originalTitle = filmOriginalTitle
        film.poster = filmPoster
        film.releaseDate = releaseDate
        film.overview = overview
        film.rating = rating
        film.id = Int32(id)
        
        do {
            try privateMOC.save()
            mainMOC.performAndWait {
                
                do {
                    try mainMOC.save()
                    
                } catch let error as NSError {
                    assertionFailure("\(error)")
                }
            }
        } catch let error as NSError {
            assertionFailure("\(error)")
        }
        
        
    }
    
    func saveGenres(_ genreID: Int, genreName: String) {
        
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Genre", in: privateMOC) else { return }
        let genre = NSManagedObject(entity: entityDescription, insertInto: privateMOC) as! Genre
        genre.id = Int32(genreID)
        genre.name = genreName
        
        do {
            try privateMOC.save()
            mainMOC.performAndWait {
                
                do {
                    try mainMOC.save()
                    
                } catch let error as NSError {
                    assertionFailure("\(error)")
                }
            }
        } catch let error as NSError {
            assertionFailure("\(error)")
        }
    }
    
    func saveFavouriteFilm(_ filmTitle: String, filmOriginalTitle: String, filmRating: Float, filmOverview: String, filmPoster: Data, id: Int32) {
        
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "FavouriteFilm", in: mainMOC) else { return }
        let favouriteFilm = NSManagedObject(entity: entityDescription, insertInto: mainMOC) as! FavouriteFilm
        favouriteFilm.title = filmTitle
        favouriteFilm.originalTitle = filmOriginalTitle
        favouriteFilm.overview = filmOverview
        favouriteFilm.rating = filmRating
        favouriteFilm.poster = filmPoster
        favouriteFilm.id = id
        
        do {
            try mainMOC.save()
            FavoritesCollectionViewViewModel.favoriteFilms.append(favouriteFilm)
        } catch let error as NSError {
            assertionFailure("\(error)")
        }
        
        
    }
    
    //MARK: Fetching methods -
    func fetchFilmsData() -> [CurrentFilm]? {
        
        let fetchRequest: NSFetchRequest<CurrentFilm> = CurrentFilm.fetchRequest()
        
        do {
            let array = try mainMOC.fetch(fetchRequest)
            return array
            
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    func fetchGenresData() -> [Genre]? {
        
        let fetchRequest: NSFetchRequest<Genre> = Genre.fetchRequest()
        
        do {
            let genres = try mainMOC.fetch(fetchRequest)
            return genres
            
        } catch let error as NSError {
            print(error)
        }
        return nil
        
    }
    
    func fetchFavouriteFilms() {
        
        let fetchRequest: NSFetchRequest<FavouriteFilm> = FavouriteFilm.fetchRequest()
        
        do {
            FavoritesCollectionViewViewModel.favoriteFilms = try mainMOC.fetch(fetchRequest)
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    func fetchIDs(id: ID) {
        switch id {
        
        case .film:
            let fetchRequest: NSFetchRequest<CurrentFilm> = CurrentFilm.fetchRequest()
            do {
                let films = try mainMOC.fetch(fetchRequest)
                for film in films {
                    setOfIDs.insert(Int32(film.id))
                }
            } catch let error as NSError {
                print(error)
            }
            
        default:
            let fetchRequest: NSFetchRequest<Genre> = Genre.fetchRequest()
            do {
                let genres = try mainMOC.fetch(fetchRequest)
                for genre in genres {
                    setOfGenres.insert(Int32(genre.id))
                    
                }
            } catch let error as NSError {
                assertionFailure("\(error)")
            }
        }
        
        
        
    }
    
    func fetchGenresID() {
        
    }
    
    
    //MARK: Deliting methods -
    func removeFromFavorites(film: FavouriteFilm) {
        let id = film.id
        let fetchRequest: NSFetchRequest<FavouriteFilm> = FavouriteFilm.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", "\(String(describing: id))")
        fetchRequest.predicate = predicate
        
        do {
            let favFilms = try privateMOC.fetch(fetchRequest) as [NSManagedObject]
            print(favFilms.count)
            for item in favFilms {
                
                privateMOC.delete(item)
            }
            try privateMOC.save()
            mainMOC.performAndWait {
                do {
                    try mainMOC.save()
                } catch let error as NSError {
                    assertionFailure("\(error)")
                }
            }
        } catch let error as NSError {
            
            assertionFailure("\(error)")
        }
    }
    
    func deleteAllData() {
        
        let fetchRequest: NSFetchRequest<CurrentFilm> = CurrentFilm.fetchRequest()
        let genreFetchRequest: NSFetchRequest<Genre> = Genre.fetchRequest()
        fetchRequest.includesPropertyValues = false
        
        do {
            let items = try privateMOC.fetch(fetchRequest) as [NSManagedObject]
            for item in items {
                privateMOC.delete(item)
            }
            try privateMOC.save()
            mainMOC.performAndWait {
                do {
                    try mainMOC.save()
                } catch let error as NSError {
                    assertionFailure("\(error)")
                }
            }
        } catch let error as NSError {
            assertionFailure("\(error)")
        }
        
        do {
            let items = try privateMOC.fetch(genreFetchRequest) as [NSManagedObject]
            for item in items {
                privateMOC.delete(item)
            }
            try privateMOC.save()
            mainMOC.performAndWait {
                do {
                    try mainMOC.save()
                    
                } catch let error as NSError {
                    assertionFailure("\(error)")
                }
            }
        } catch let error as NSError {
            assertionFailure("\(error)")
        }
    }
    
    func deleteAllDataFromFavourites() {
        
        let fetchRequest: NSFetchRequest<FavouriteFilm> = FavouriteFilm.fetchRequest()
        fetchRequest.includesPropertyValues = false
        
        do {
            let favFilms = try mainMOC.fetch(fetchRequest) as [NSManagedObject]
            for film in favFilms {
                mainMOC.delete(film)
            }
            try mainMOC.save()
            FavoritesCollectionViewViewModel.favoriteFilms.removeAll()
        } catch let error as NSError {
            print(error)
        }
    }
    
    deinit {
        print("CoreData manager was dealocated")
    }
}
