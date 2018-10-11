//
//  NovelOverviewList.swift
//  NarouAPITest
//
//  Created by yoshiki-t on 2018/10/08.
//  Copyright © 2018 yoshiki-t. All rights reserved.
//

import Foundation

struct NovelOverviewList {
    let metaData: MetaData
    let novelOverviews: [NoveiOverview]
    
    init(metaData: MetaData, novelOverviews: [NoveiOverview]) {
        self.metaData = metaData
        self.novelOverviews = novelOverviews
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
