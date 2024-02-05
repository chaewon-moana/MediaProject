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

    func fetchDrama(api: TMDBAPI, completionHandler: @escaping (([Drama]) -> Void)) {
        AF.request(api.endPoint, headers: header).responseDecodable(of: DramaModel.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success.results)
            case .failure(let failure):
                print("fail", failure)
            }
        }
    }
    
    let header: HTTPHeaders = ["Authorization": APIKey.tmdbAPIKey]
    let baseURL = "https://api.themoviedb.org/3/"
    
    func fetchDetailModel(id: Int,completionHandler: @escaping ((Detail) -> Void)) {
        let url = baseURL + "tv/\(id)?language=ko-KR"
        
        AF.request(url, headers: header).responseDecodable(of: Detail.self) { response in
            switch response.result {
            case .success(let success):
               // print("detail Model success", success)
                completionHandler(success)
            case .failure(let failure):
                print("failure", failure)
            }
        }
    }
    
    func fetchCreditsModel(id: Int,complectionHandler: @escaping ((DramaCredits) -> Void)) {
        let url = baseURL + "tv/\(id)/aggregate_credits?language=ko-KR"
        
        AF.request(url, headers: header).responseDecodable(of: DramaCredits.self) { response in
            switch response.result {
            case .success(let success):
                complectionHandler(success)
            case .failure(let failure):
                print("캐스팅 정보 실패" ,failure)
            }
        }
    }
    
    func fetchRecommandationModel(id: Int, complectionHandler: @escaping ((DramaRecommandation) -> Void)) {
        let url = baseURL + "tv/\(id)/recommendations"
        
        AF.request(url, headers: header).responseDecodable(of: DramaRecommandation.self) { response in
            switch response.result {
            case .success(let success):
                complectionHandler(success)
            case .failure(let failure):
                print("땡!!", failure)
            }
        }
    }
}
