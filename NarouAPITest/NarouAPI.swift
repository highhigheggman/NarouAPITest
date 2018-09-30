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
    
    func getTitles() {
        let parameters: Parameters = [
            "out" : "json",
            "order" : "hyoka",
            
        ]
        Alamofire.request(baseURL,method: .get, parameters: parameters, encoding: JSONEncoding.default).response { response in
            guard let data = response.data else { return }
            print("get")
            print(data as Any)
        }
    }
    
    
    
}
