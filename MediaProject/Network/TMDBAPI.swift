//
//  TMDBAPI.swift
//  MediaProject
//
//  Created by cho on 2/5/24.
//

import Foundation
import Alamofire

enum TMDBAPI {
    
    case trending
    case topRated
    case popluar
    case search(query: String)
        
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endPoint: URL {
        switch self {
        case .trending:
            return URL(string: baseURL + "trending/tv/day?language=ko-KR")!
        case .topRated:
            return URL(string: baseURL + "tv/top_rated?language=ko-KR?page=1")!
        case .popluar:
            return URL(string: baseURL + "tv/popular?language=ko-KR?page=1")!
        case .search:
            return URL(string: baseURL + "search/tv")!
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": APIKey.tmdbAPIKey]
    }
    
    var parameter: Parameters {
        switch self {
        case .trending:
            return ["": ""]
        case .topRated:
            return ["": ""]
        case .popluar:
            return ["": ""]
        case .search(let query):
            return ["query": query]
        }
    }
}
