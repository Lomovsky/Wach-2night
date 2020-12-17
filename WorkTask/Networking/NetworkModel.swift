//
//  NetworkModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 11.12.2020.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let title, year, rated, released: String
    let runtime, genre, director, writer: String
    let actors, plot, language: String
    let country: Country
    let awards: String
    let poster: String
    let ratings: [Rating]
    let metascore, imdbRating, imdbVotes, imdbID: String
    let type: TypeEnum
    let dvd, boxOffice, production: String?
    let website: Website?
    let response: Response
    let totalSeasons: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating, imdbVotes, imdbID
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
        case totalSeasons
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.year = try container.decode(String.self, forKey: .year)
        self.rated = try container.decode(String.self, forKey: .rated)
        self.released = try container.decode(String.self, forKey: .released)
        self.runtime = try container.decode(String.self, forKey: .runtime)
        self.genre = try container.decode(String.self, forKey: .genre)
        self.director = try container.decode(String.self, forKey: .director)
        self.writer = try container.decode(String.self, forKey: .writer)
        self.actors  = try container.decode(String.self, forKey: .actors)
        self.plot = try container.decode(String.self, forKey: .plot)
        self.language = try container.decode(String.self, forKey: .language)
        self.country = try container.decode(Country.self, forKey: .country)
        self.awards = try container.decode(String.self, forKey: .awards)
        self.poster = try container.decode(String.self, forKey: .poster)
        self.ratings = try container.decode([Rating].self, forKey: .ratings)
        self.metascore = try container.decode(String.self, forKey: .metascore)
        self.imdbRating = try container.decode(String.self, forKey: .imdbRating)
        self.imdbVotes = try container.decode(String.self, forKey: .imdbVotes)
        self.imdbID  = try container.decode(String.self, forKey: .imdbID)
        self.type  = try container.decode(TypeEnum.self, forKey: .type)
        self.dvd = try container.decode(String?.self, forKey: .dvd)
        self.boxOffice = try container.decode(String?.self, forKey: .boxOffice)
        self.production = try container.decode(String?.self, forKey: .production)
        self.website = try container.decode(Website.self, forKey: .website)
        self.response = try container.decode(Response.self, forKey: .response)
        self.totalSeasons = try container.decode(String?.self, forKey: .totalSeasons)
    }
    
}

enum Country: String, Codable {
    case newZealand = "New Zealand"
    case usa = "USA"
    case usaSouthKorea = "USA, South Korea"
}

// MARK: - Rating
struct Rating: Codable {
    let source: Source
    let value: String

    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}

enum Source: String, Codable {
    case internetMovieDatabase = "Internet Movie Database"
    case metacritic = "Metacritic"
    case rottenTomatoes = "Rotten Tomatoes"
}

enum Response: String, Codable {
    case responseTrue = "True"
}

enum TypeEnum: String, Codable {
    case movie = "movie"
    case series = "series"
}

enum Website: String, Codable {
    case nA = "N/A"
}

typealias Welcome = [WelcomeElement]
