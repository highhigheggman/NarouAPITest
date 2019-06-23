//
//  NovelListViewModel.swift
//  NarouAPITest
//
//  Created by yoshiki-t on 2018/11/03.
//  Copyright © 2018 yoshiki-t. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class NovelListViewModel {
    
    private let novelListRelay = BehaviorRelay<[NovelInfo]>(value: [])
    private let disposeBag = DisposeBag()
    private let narouManager = NarouManager()
    
    // Output to View
    var canReferesh: Bool
    
    init(refresh: Signal<()>) {
        
        // Refresh Button State
        self.canReferesh = true
        
        refresh
            .emit(onNext: { [weak self] _ in
                guard let self = self else {return}
                self.canReferesh = false
                self.narouManager.updateNovelList()
                
                if let novel = self.narouManager.novelList.first {
                    self.narouManager.getNovelBody(novel.ncode, episode: 1)
                    self.narouManager.getNovelChapterList(novel.ncode)
                }
            })
            .disposed(by: disposeBag)
        
        
    }
    
}
