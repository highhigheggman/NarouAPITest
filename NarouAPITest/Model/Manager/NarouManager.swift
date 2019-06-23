//
//  NovelListModel.swift
//  NarouAPITest
//
//  Created by yoshiki-t on 2018/11/03.
//  Copyright © 2018 yoshiki-t. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class NarouManager {
    
    var novelList: [NovelInfo]
    
    let narouAPI: NarouAPI
    let narouScraper: NarouScraper
    
    init() {
        narouAPI = NarouAPI()
        narouScraper = NarouScraper()
        novelList = []
    }
    
    func updateNovelList() {
        narouAPI.getNovelInfo(sortOption: .hyoka, limit: 50, completion: { apiResponse, error in
            
            guard let data = apiResponse else {
                print("Error: \(error!)")
                return
            }
            
            if let novel = data.novelInfoList.first {
                print("\(novel.ncode): \(novel.title)")
            }
            
            print(String(data.novelInfoList.count) + "/" + String(data.metaData.allcount))
            
            self.novelList = data.novelInfoList
        })
    }
    
    func getNovelBody(_ ncode: String, episode: Int) {
        narouScraper.getNovelBody(ncode, episode, completion: { (respones, error) in
            if let _ = error { return }
            print(respones?.title ?? "")
        })
    }

    func getNovelChapterList(_ ncode: String) {
        narouScraper.getNovelChapterList(ncode, completion: { (response, error) in
            if let _ = error { return }
            response.forEach { chapter in
                print(chapter.title ?? "")
            }
        })
    }
}
