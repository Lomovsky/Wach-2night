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
//    let privateMOC = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.newBackgroundContext()
    var setOfIDs = Set<Int32>()
    var setOfGenres = Set<Int32>()
    
    //MARK: Saving funcs
    func checkForExistance(filmTitle: String, filmOriginalTitle: String, filmPoster: Data, releaseDate: String, overview: String, rating: Float, id: Int, isFav: Bool) {
        fetchIDs(id: .film)
        
        if setOfIDs.contains(Int32(id)) {
            print("Already exists")
        } else {
            saveFilms(filmTitle, filmOriginalTitle: filmOriginalTitle, filmPoster: filmPoster, releaseDate: releaseDate, overview: overview, rating: rating, id: id, isFav: isFav)
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
    
    
    func saveFilms(_ filmTitle: String, filmOriginalTitle: String, filmPoster: Data, releaseDate: String, overview: String, rating: Float, id: Int, isFav: Bool) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "CurrentFilm", in: mainMOC) else { return }
        let film = NSManagedObject(entity: entityDescription, insertInto: mainMOC) as! CurrentFilm
        
        film.title = filmTitle
        film.originalTitle = filmOriginalTitle
        film.poster = filmPoster
        film.releaseDate = releaseDate
        film.overview = overview
        film.rating = rating
        film.id = Int32(id)
        film.isFavorite = isFav
        
        do {
            try mainMOC.save()
//            mainMOC.performAndWait {
//
//                do {
//                    try mainMOC.save()
//
//                } catch let error as NSError {
//                    assertionFailure("\(error)")
//                }
//            }
        } catch let error as NSError {
            assertionFailure("\(error)")
        }
        
        
    }
    
    func saveGenres(_ genreID: Int, genreName: String) {
        
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Genre", in: mainMOC) else { return }
        let genre = NSManagedObject(entity: entityDescription, insertInto: mainMOC) as! Genre
        genre.id = Int32(genreID)
        genre.name = genreName
        
        do {
            try mainMOC.save()
//            mainMOC.performAndWait {
//
//                do {
//                    try mainMOC.save()
//
//                } catch let error as NSError {
//                    assertionFailure("\(error)")
//                }
//            }
        } catch let error as NSError {
            assertionFailure("\(error)")
        }
    }
    
    func saveFavouriteFilm(film: CurrentFilm) {
        
        let fetchRequest: NSFetchRequest<CurrentFilm> = CurrentFilm.fetchRequest()
        
        do {
            let results = try mainMOC.fetch(fetchRequest)
            for item in results {
                if item.id == film.id {
                    item.isFavorite = true
                }
            }
            try mainMOC.save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    //MARK: Fetching methods -
    func fetchFilmsData() -> [CurrentFilm] {
        
        let fetchRequest: NSFetchRequest<CurrentFilm> = CurrentFilm.fetchRequest()
        
        do {
            let array = try mainMOC.fetch(fetchRequest)
            return array
            
        } catch let error as NSError {
            print(error)
        }
        return []
    }
    
    func fetchGenresData() -> [Genre] {
        
        let fetchRequest: NSFetchRequest<Genre> = Genre.fetchRequest()
        
        do {
            let genres = try mainMOC.fetch(fetchRequest)
            return genres
            
        } catch let error as NSError {
            print(error)
        }
        return []
        
    }
    
    func fetchFavouriteFilms() -> [CurrentFilm] {
        let fetchRequest: NSFetchRequest<CurrentFilm> = CurrentFilm.fetchRequest()
        var array: [CurrentFilm] = []
        
        do {
            let results = try mainMOC.fetch(fetchRequest)
            for item in results {
                if item.isFavorite == true {
                    array.append(item)
                }
            }
        } catch let error as NSError {
            print(error)
        }
        return array
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
                try mainMOC.save()
                
            } catch let error as NSError {
                assertionFailure("\(error)")
            }
        }
        
        
        
    }
    
    
    //MARK: Deliting methods -
    func removeFromFavorites(film: CurrentFilm) {
        let fetchRequest: NSFetchRequest<CurrentFilm> = CurrentFilm.fetchRequest()
        
        do {
            let results = try mainMOC.fetch(fetchRequest)
            for item in results {
                if item.id == film.id {
                    item.isFavorite = false
                }
            }
            try mainMOC.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    func deleteAllData() {
        
        let fetchRequest: NSFetchRequest<CurrentFilm> = CurrentFilm.fetchRequest()
        let genreFetchRequest: NSFetchRequest<Genre> = Genre.fetchRequest()
        fetchRequest.includesPropertyValues = false
        
        do {
            let items = try mainMOC.fetch(fetchRequest) as [NSManagedObject]
            for item in items {
                mainMOC.delete(item)
            }
            try mainMOC.save()
//            mainMOC.performAndWait {
//                do {
//                    try mainMOC.save()
//                } catch let error as NSError {
//                    assertionFailure("\(error)")
//                }
//            }
        } catch let error as NSError {
            assertionFailure("\(error)")
        }
        
        do {
            let items = try mainMOC.fetch(genreFetchRequest) as [NSManagedObject]
            for item in items {
                mainMOC.delete(item)
            }
            try mainMOC.save()
//            mainMOC.performAndWait {
//                do {
//                    try mainMOC.save()
//
//                } catch let error as NSError {
//                    assertionFailure("\(error)")
//                }
//            }
        } catch let error as NSError {
            assertionFailure("\(error)")
        }
    }
    
    func deleteAllDataFromFavourites() {
        
        let fetchRequest: NSFetchRequest<CurrentFilm> = CurrentFilm.fetchRequest()
        
        do {
            let favFilms = try mainMOC.fetch(fetchRequest)
            for film in favFilms {
                film.isFavorite = false
            }
            
            try mainMOC.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    deinit {
        print("CoreData manager was dealocated")
    }
}
