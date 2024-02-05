//
//  TMDBSessionManager.swift
//  MediaProject
//
//  Created by cho on 2/5/24.
//

import Foundation

class TMDBSessionManager {
    static let shared = TMDBSessionManager()
    
    func fetchDrama(api: TMDBAPI, completionHandler: @escaping (([Drama]?, Error?) -> Void)) {
        var url = URLRequest(url: api.endPoint)
        url.httpMethod = "GET"
        url.addValue(APIKey.tmdbAPIKey, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: url) { data, response, error in
                
                guard error == nil else {
                    print("네트워크 통신 실패")
                    return
                }
                
                guard let response = response else {
                    print("응답이 이상하게 왔음요!")
                    return
                }
                
                guard let data = data else {
                    print("데이터 안 왔따요!")
                    return
                }
            
            do {
                let result = try JSONDecoder().decode(DramaModel.self, from: data)
                completionHandler(result.results, nil)
            } catch {
                print("do catch 에러", error)
            }
        }.resume()
        
    }
}
