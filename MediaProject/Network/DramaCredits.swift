//
//  DramaCredits.swift
//  MediaProject
//
//  Created by cho on 2/2/24.
//

import Foundation

struct DramaCredits: Decodable {
    let cast: [Cast]

}

struct Cast: Decodable {
    let gender: Int //1 - 여자, 2 - 남자
    let name: String
    //let role: [Role]?
    let profile_path: String?
    
}

struct Role: Decodable {
    let character: String?
}
