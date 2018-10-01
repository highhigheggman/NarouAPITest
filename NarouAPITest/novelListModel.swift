//
//  novelListModel.swift
//  NarouAPITest
//
//  Created by yoshiki-t on 2018/09/30.
//  Copyright © 2018 yoshiki-t. All rights reserved.
//

import Foundation

struct NovelOverviewModel: Codable {
    let title: String
    let ncode: String
    let userid: String
    let writer: String
    let story: String
    let general_lastup: Date
    let global_point: Int
}
