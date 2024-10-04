//
//  NetworkingResposne.swift
//  
//
//  Created by Zain ul Abe Din on 09/09/2024.
//

import Foundation

struct Response<T: Decodable>: Decodable {
    let result: T
}

extension Response {
    init(from decoder: Decoder) throws {
        result = try T.init(from: decoder)
    }
}
