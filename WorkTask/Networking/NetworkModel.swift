//
//  NetworkModel.swift
//  WorkTask
//
//  Created by Алекс Ломовской on 11.12.2020.
//

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
