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
    
    /// 小説の本文情報を取得
    func getNovelBody(_ ncode: String, _ episode: Int, completion: @escaping (NarouScraperBody?, Error?) -> ()) {
        let url = baseURL + ncode + "/\(String(episode))"
        var scraperResponse: NarouScraperBody?
        var scraperError: NarouScraperError?
        
        Alamofire.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseString { response in
                
                switch response.result {
                case .success:
                    guard let html = response.value else {return}
                    scraperResponse = self.parseNovelBody(html)
                case.failure:
                    scraperError = .server
                }
                
                completion(scraperResponse, scraperError)
        }
    }
    
    private func parseNovelBody(_ html: String) -> NarouScraperBody? {
        guard let doc = try? HTML(html: html, encoding: .utf8) else {
            return nil
        }
        
        let title = doc.xpath("//*[@id=\"novel_color\"]/p").first?.text ?? ""
        let body = doc.xpath("//*[@id=\"novel_honbun\"]").compactMap { $0.text }
        
        return NarouScraperBody(title, body)
    }
    
    /// 章区切りのタイトルリストを取得
    func getNovelChapterList(_ ncode: String) {
        let url = baseURL + ncode
        var scraperResponse =  [NarouScraperChapter]()
        var scraperError: NarouScraperError?
        
        Alamofire.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseString { response in
                
                switch response.result {
                case .success:
                    guard let html = response.value else {return}
                    scraperResponse = self.parseNovelChapterList(html)
                case.failure:
                    scraperError = .server
                }
        }
        
    }
    
    private func parseNovelChapterList(_ html: String) -> [NarouScraperChapter] {
        guard let doc = try? HTML(html: html, encoding: .utf8) else {
            return []
        }
        
        let elemnts = doc.xpath("//*[@id=\"novel_color\"]/div[3]/*")
        var chapters = [NarouScraperChapter]()
        var chapterIndex = 0
        
        elemnts.forEach { element in
            if element.className == "chapter_title" {
                chapters.append(NarouScraperChapter(title: element.text ?? "", episodes: []))
                chapterIndex = (chapterIndex != 0 ? chapterIndex : chapterIndex + 1)
                print(element.text ?? "")

            } else if element.className == "novel_sublist2" {
                let title = element.at_xpath("dd[@class='subtitle']")?.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                let dateString = element.at_xpath("dt[@class='long_update']/text()")?.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                let didUpdate = element.at_xpath("dt[@class='long_update']/span") != nil
                print("episode:\(title ?? ""), \(dateString ?? ""), \(didUpdate ? "[update]": "")")
            }
        }
        
        return chapters
    }
    
}

enum NarouScraperError: Error {
    case network
    case server
    case parse
    case unknown(String)
}

