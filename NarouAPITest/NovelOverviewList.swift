//
//  NovelOverviewList.swift
//  NarouAPITest
//
//  Created by yoshiki-t on 2018/10/08.
//  Copyright © 2018 yoshiki-t. All rights reserved.
//

import Foundation

struct MetaData: Codable {
    let allcount: Int
}

struct NoveiOverview: Codable {
    var title: String
    var ncode: String
    var userid: Int
    var writer: String
    var story: String
    
    var generalLastup: String
    var globalPoint: Int
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case ncode = "ncode"
        case userid = "userid"
        case writer = "writer"
        case story = "story"
        case generalLastup = "general_lastup"
        case globalPoint = "global_point"
    }
}

struct NovelOverviewList {
    let metaData: MetaData
    let novelOverviews: [NoveiOverview]
    
    init(metaData: MetaData, novelOverviews: [NoveiOverview]) {
        self.metaData = metaData
        self.novelOverviews = novelOverviews
        
        print(self.metaData)
        print(self.novelOverviews)
    }
    
}

extension NovelOverviewList: Decodable {
    
    init(from decoder: Decoder) throws {
        var meta: MetaData = MetaData(allcount: 0)
        var overviews: [NoveiOverview] = []
        var unkeyedContainer = try decoder.unkeyedContainer()
        
        while !unkeyedContainer.isAtEnd {
            // unkeyedContainer.currentIndex: decodeが成功するたびにインクリメントされる
            
            do {
                // index 0: MetaData
                if unkeyedContainer.currentIndex == 0 {
                    meta = try unkeyedContainer.decode(MetaData.self)
                    
                } else {
                    let overview = try unkeyedContainer.decode(NoveiOverview.self)
                    overviews.append(overview)
                }
            
            } catch {
                print("error")
            }

        }
        
        self.init(metaData: meta, novelOverviews: overviews)
    }
}
