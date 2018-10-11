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
    
    func getOverViewList(sortOption: NarouSortOption) {
        let parameters: Parameters = [
            "out" : "json",
            "order" : sortOption.rawValue,
            "of" : "t-n-u-w-s-gp-gl",
            
        ]
        
        Alamofire.request(baseURL,method: .get, parameters: parameters)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData  { response in
                
                switch response.result {
                case .success:
                    guard let data = response.data else { return }
                    let novelOverviewList: NovelOverviewList? = try? JSONDecoder().decode(NovelOverviewList.self, from: data)
                    
                    if let novelOverviewList = novelOverviewList {
                        print(novelOverviewList.novelOverviews)
                    }
                    
                case.failure(let error):
                    print(error)
                }
            

            
        }
    }
    
    
    
}
