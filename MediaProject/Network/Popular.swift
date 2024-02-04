//
//  Popular.swift
//  MediaProject
//
//  Created by cho on 1/31/24.
//

import Foundation

struct Popular: Decodable {
    let results: [PopularTV]
}

struct PopularTV: Decodable {
    let adult: Bool
    let id: Int
    let overview: String
    let name: String
    let poster_path: String?
    let backdrop_path: String?
}
