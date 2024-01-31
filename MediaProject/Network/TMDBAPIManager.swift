//
//  TMDBAPIManager.swift
//  MediaProject
//
//  Created by cho on 1/31/24.
//

import Foundation
import Alamofire

class TMDBAPIManager {
    static let shared = TMDBAPIManager() // 이 한곳에다가만 만들어두어서 저장공간이 낭비되지 않도록 함!
    let header: HTTPHeaders = ["Authorization": APIKey.tmdbAPIKey]
    let baseURL = "https://api.themoviedb.org/3/"
    
    func fetchTrendTV(completionHandler: @escaping (([TrendTV]) -> Void)) {
        let url = baseURL + "trending/tv/day?language=ko-KR"
    
        AF.request(url, headers: header).responseDecodable(of: TrendModel.self) { response in
            switch response.result {
            case .success(let success):
               // print("success", success.results)
                
                completionHandler(success.results)
                
            case .failure(let failure):
                print("fail", failure)
            }
        }
    }
    
    
    func fetchTopRatedTV(complectionHandler: @escaping (([TopTV]) -> Void)) {
        let url = baseURL + "tv/top_rated?language=ko-KR?page=1"
        
        AF.request(url, headers: header).responseDecodable(of: TopRated.self) { response in
            switch response.result {
            case .success(let success):
                //print("success", success)
                
                complectionHandler(success.results)
                
            case .failure(let failure):
                print("fail", failure)
            }
        }
    }
    
    func fetchPopularTV(completionHandler: @escaping (([PopularTV]) -> Void)) {
        let url = baseURL + "tv/popular?language=ko-KR?page=1"
        
        AF.request(url, headers: header).responseDecodable(of: Popular.self) { response in
            switch response.result {
            case .success(let success):
                print("success", success)
                
                completionHandler(success.results)
            case .failure(let failure):
                print("fail", failure)
            }
        }
    }
}
