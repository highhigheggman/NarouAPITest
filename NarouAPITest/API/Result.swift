//
//  NarouResult.swift
//  NarouAPITest
//
//  Created by yoshiki-t on 2018/10/14.
//  Copyright © 2018 yoshiki-t. All rights reserved.
//

enum NarouResult <T> {
    case success(T)
    case failure(Error)
}
