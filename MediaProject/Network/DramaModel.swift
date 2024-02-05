//
//  DramaModel.swift
//  MediaProject
//
//  Created by cho on 2/5/24.
//

import Foundation

struct DramaModel: Decodable { //받아오기만 할거니까 Decodable만 써도 충분! 파파고번역처럼 서버에 보내야하는 게 있다면 encodable 해야함!
    let results: [Drama]
}

struct Drama: Decodable {
    let adult: Bool
    let id: Int
    let backdrop: String?
    let poster: String?
    let name: String
    let originalName: String
    let overview: String?
    let firstAirDate: String
    let rating: Double
    let genres: [Int]
    
    enum CodingKeys: String, CodingKey {
        //서버에서 받아온 이름이 아닌 내가 이름을 정해서 하고 싶다면 CodingKeys 사용!,,,반대로 받아와야하네,,,
        case adult
        case id
        case backdrop = "backdrop_path"
        case poster = "poster_path"
        case name
        case originalName = "original_name"
        case overview
        case firstAirDate = "first_air_date"
        case rating = "vote_average"
        case genres = "genre_ids"
    }
}

/*
 Let popularity: Double
    let originCountry: [String]
    let voteCount: Int

<애매쓰>
    let mediaType: MediaType -> trending 모델
    let originalLanguage: OriginalLanguage(or String)
 */
