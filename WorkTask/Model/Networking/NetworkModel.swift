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
    let title: String
    let writer: String
    let genre: String
    let poster: String
    

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case writer = "Writer"
        case genre = "Genre"
        case poster = "Poster"
 
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.writer = try container.decode(String.self, forKey: .writer)
        self.genre = try container.decode(String.self, forKey: .genre)
        self.poster = try container.decode(String.self, forKey: .poster)
       
    }
    
}
typealias Welcome = [WelcomeElement]


