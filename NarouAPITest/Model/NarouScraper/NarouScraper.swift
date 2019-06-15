//
//  NarouScraper.swift
//  NarouAPITest
//
//  Created by yoshiki-t on 2019/06/12.
//  Copyright © 2019 yoshiki-t. All rights reserved.
//

import Alamofire
import Kanna

/// 小説家になろうへのスクレイピングを扱うクラス
/// 小説の本文、各話のリストを取得する
class NarouScraper {
    
    var baseURL: String
    
    init() {
        baseURL = "https://ncode.syosetu.com/"
    }
    
    func getNovelBody(_ ncode: String, _ episode: Int, completion: @escaping (NarouScraperResponse?, Error?) -> ()) {
        let url = baseURL + ncode + "/\(String(episode))"
        var scraperResponse: NarouScraperResponse?
        var scraperError: NarouScraperError?
        
        Alamofire.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseString { response in
                
                switch response.result {
                case .success:
                    guard let html = response.value else {return}
                    scraperResponse = self.parseNovelBody(html: html)
                case.failure:
                    scraperError = .server
                }
                
                completion(scraperResponse, scraperError)
        }
    }
    
    private func parseNovelBody(html: String) -> NarouScraperResponse? {
        guard let doc = try? HTML(html: html, encoding: .utf8) else {
            return nil
        }
        
        let title = doc.xpath("//*[@id=\"novel_color\"]/p").first?.text ?? ""
        let body = doc.xpath("//*[@id=\"novel_honbun\"]").compactMap { $0.text }
        
        return NarouScraperResponse(title, body)
    }
}

enum NarouScraperError: Error {
    case network
    case server
    case parse
    case unknown(String)
}

