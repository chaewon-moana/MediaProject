//
//  File.swift
//  MediaProject
//
//  Created by cho on 1/31/24.
//

import Foundation


struct DetailModel: Decodable {
    let result: Detail
}

struct Detail: Decodable {
    let id: Int
    let name: String
    let poster: String?
    let backdrop: String?
    let rating: Double
    let overview: String?
//    let adult: Bool

//    let runtime: [Int]
//    let firstAirDate: String
//    let genres: [Genre]
//    let homepage: String
//   
//    let lastAirEpisode: AirEpisode
//    
//    let nextAirEpisode: AirEpisode
//    let numOfEpisode: Int
//    let numOfSeason: Int
    
    
    enum CodingKeys: String, CodingKey {
        //case adult
        case id
        case name
        case poster = "poster_path"
        case backdrop = "backdrop_path"
        case rating = "vote_average"
        case overview
//        case runtime = "episode_run_time"
//        case firstAirDate = "first_air_date"
//        case genres
//        case homepage
//       
//        case lastAirEpisode = "last_episode_to_air"
//       
//        case nextAirEpisode = "next_episode_to_air"
//        case numOfEpisode = "number_of_episodes"
//        case numOfSeason = "number_of_seasons"
        
    }
}

struct AirEpisode: Decodable {
    let id: Int
    let name: String
    let overview: String
    let airDate: String
    let episodeNumber: Int
    let runtime: Int
    let season_number: Int
    let still_path: String
}

struct Genre: Decodable {
    let id: Int
    let name: String
}

