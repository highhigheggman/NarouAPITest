//
//  NarouAPIError.swift
//  NarouAPITest
//
//  Created by yoshiki-t on 2018/10/13.
//  Copyright © 2018 yoshiki-t. All rights reserved.
//

enum NarouAPIError: Error {
    case network
    case server
    case parseJSON
    case unknown(String)
}
