//
//  NarouAPI.swift
//  NarouAPITest
//
//  Created by yoshiki-t on 2018/09/29.
//  Copyright © 2018 yoshiki-t. All rights reserved.
//

import Alamofire

class NarouAPI {
    
    var baseURL: String
    
    init() {
        baseURL = "https://api.syosetu.com/novelapi/api/"
    }
    
    func getNovelInfo(sortOption: NarouSortOption, completion: @escaping (NarouAPIResponse?, Error?) -> ()){
        
        let parameters: Parameters = [
            "out" : "json",
            "order" : sortOption.rawValue,
            "of" : "t-n-u-w-s-gp-gl",
            
        ]
        
        Alamofire.request(baseURL,method: .get, parameters: parameters)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                
                var apiResponse: NarouAPIResponse? = nil
                var apiError: NarouAPIError? = nil
                
                switch response.result {
                case .success:
                    guard let data = response.data else { return }
                    do {
                        apiResponse = try JSONDecoder().decode(NarouAPIResponse.self, from: data)
                    } catch {
                        apiError = NarouAPIError.parseJSON
                    }
                    
                case.failure:
                    apiError = NarouAPIError.network
                }
                
                completion(apiResponse, apiError)
            
        }
    }
    
    
    
}
