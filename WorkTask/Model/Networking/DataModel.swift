 
 
import Foundation

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
