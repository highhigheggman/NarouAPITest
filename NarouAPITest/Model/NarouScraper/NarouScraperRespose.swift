//
//  NarouScraperRespose.swift
//  NarouAPITest
//
//  Created by yoshiki-t on 2019/06/15.
//  Copyright © 2019 yoshiki-t. All rights reserved.
//

import Foundation

struct NarouScraperBody {
    var title: String
    var body: [String]
    
    init(_ title: String?, _ body: [String]) {
        self.title = title ?? ""
        self.body = body
    }
}

struct NarouScraperChapter {
    var title: String
    var episodes: [(title: String, updateDateString: String)]
}
