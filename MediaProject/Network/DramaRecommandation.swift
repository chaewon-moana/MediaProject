//
//  DramaRecommandation.swift
//  MediaProject
//
//  Created by cho on 2/3/24.
//

import Foundation

struct DramaRecommandation: Decodable {
    let results: [Recommandation]
}

struct Recommandation: Decodable {
    let backdrop_path: String?
    let id: Int
    let name: String
    let poster_path: String?
}
