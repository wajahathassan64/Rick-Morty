//
//  NetworkingRequestType.swift
//
//
//  Created by Zain ul Abe Din on 09/09/2024.
//

import Foundation

public typealias RouterInput<T> = (body: T?, query: [String: String]?, pathVariables: [String]?)

public enum NetworkingRequestType {
    case json
}

extension NetworkingRequestType {
    var requestHeaders: [String: String] {
        var headers = [String: String]()
        switch self {
        case .json:
            headers["Content-Type"] = "application/json"
            headers["Accept"] = "application/json"
        }
        return headers
    }
}
