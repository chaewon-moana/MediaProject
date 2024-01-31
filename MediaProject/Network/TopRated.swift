//
//  TopRated.swift
//  MediaProject
//
//  Created by cho on 1/31/24.
//

import Foundation

struct TopRated: Decodable {
    let results: [TopTV]
}

struct TopTV: Decodable {
    let adult: Bool
    let backdrop: String
    let id: Int
    let overview: String
    let poster: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdrop = "backdrop_path"
        case id
        case overview
        case poster = "poster_path"
        case name
    }
}
