 
 
import Foundation

// MARK: - WelcomeElement

 struct FilmResponse: Codable {
    var page: Int
    var results: [Film]
 }
 
 struct Film: Codable {
    var title: String
    var originalTitle: String
    var posterPath: String?
    var releaseDate: String
    var overview: String
    var rating: Float
    
    enum CodingKeys: String, CodingKey {
        case title
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case overview
        case rating = "vote_average"
    }
    
 }
 
 struct SearchedFilm {
    var title: String
    var originalTitle: String
    var poster: Data?
    var releaseDate: String
    var overview: String
    var rating: Float
 }
 
 struct Genres: Codable {
    var id: Int
    var name: String
 }
