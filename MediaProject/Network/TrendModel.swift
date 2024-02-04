//
//  TrendModel.swift
//  MediaProject
//
//  Created by cho on 1/31/24.
//

import Foundation

struct TrendModel: Decodable { //받아오기만 할거니까 Decodable만 써도 충분! 파파고번역처럼 서버에 보내야하는 게 있다면 encodable 해야함!
    let results: [TrendTV]
}

struct TrendTV: Decodable {
    let adult: Bool
    let id: Int
    let backdrop: String
    let name: String
    //let original_name: String
    let overview: String
    let poster: String
    
    enum CodingKeys: String, CodingKey {
        //서버에서 받아온 이름이 아닌 내가 이름을 정해서 하고 싶다면 CodingKeys 사용!,,,반대로 받아와야하네,,,
        case adult
        case id
        case backdrop = "backdrop_path"
        case name
        //case original_name
        case overview
        case poster = "poster_path"
    }
}
