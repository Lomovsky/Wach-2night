 
 
import UIKit

// MARK: - WelcomeElement

 struct FilmResponse: Codable {
    var page: Int
    var results: [Film]
 }
 
 struct Film: Codable {
    var id: Int
    var title: String
    var originalTitle: String
    var posterPath: String?
    var releaseDate: String
    var overview: String
    var rating: Float
    
    enum CodingKeys: String, CodingKey {
        case id 
        case title
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case overview
        case rating = "vote_average"
    }
    
 }
 
 struct ConventedFilm {
    var id: Int
    var title: String
    var originalTitle: String
    var poster: UIImage?
    var releaseDate: String
    var overview: String
    var rating: Float
    
    init(id: Int, title: String, originalTitle: String, poster: UIImage, releaseDate: String, overview: String, rating: Float) {
        self.id = id
        self.title = title
        self.originalTitle = originalTitle
        self.poster = poster
        self.releaseDate = releaseDate
        self.overview = overview
        self.rating = rating
    }
 }
 
 
 // MARK: - Genre
 struct Genres: Codable {
     let genres: [GenreElement]
 }

 // MARK: - GenreElement
 struct GenreElement: Codable {
     let id: Int
     let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
 }
