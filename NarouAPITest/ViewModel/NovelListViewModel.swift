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
    
    // Output to View
    var canReferesh: Bool
    
    init(refresh: Signal<()>) {
        
        // Refresh Button State
        self.canReferesh = true
        
        refresh
            .emit(onNext: { [weak self] _ in
                guard let self = self else {return}
                self.canReferesh = false
                
                print("tap")
            })
            .disposed(by: disposeBag)
        
        
    }
    
}
