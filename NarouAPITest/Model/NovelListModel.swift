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

protocol NovelListModel {
}

class DefaultNovelListModel: NovelListModel {
    
    var novelList: [NovelInfo]
    let narouAPI: NarouAPI
    
    init() {
        narouAPI = NarouAPI()
        novelList = []
    }
    
    func updateNovelList() {
        narouAPI.getNovelInfo(sortOption: .hyoka, limit: 50, completion: { apiResponse, error in
            
            guard let data = apiResponse else {
                print("Error: \(error!)")
                return
            }
            
            print()
            print(String(data.novelInfoList.count) + "/" + String(data.metaData.allcount))
            
            self.novelList = data.novelInfoList
        })
    }
    
}
