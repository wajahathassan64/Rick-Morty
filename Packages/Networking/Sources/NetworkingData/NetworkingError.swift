//
//  NetworkingError.swift
//
//
//  Created by Zain ul Abe Din on 09/09/2024.
//

import Foundation

public enum NetworkingError: Error {
    case noInternet
    case requestTimedOut
    case unknown
}

public extension NetworkingError {
    var localizedDescription: String {
        switch self {
        case .noInternet:
            return "Looks like you're not connect to internet!"
        case .requestTimedOut:
            return "Looks like it's take too long to process your reqeust!"
        case .unknown:
            return "Oops! something bad happened"
        }
    }
}
