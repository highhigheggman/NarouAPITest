//
//  NovelOverview.swift
//  NarouAPITest
//
//  Created by yoshiki-t on 2018/10/10.
//  Copyright © 2018 yoshiki-t. All rights reserved.
//

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
