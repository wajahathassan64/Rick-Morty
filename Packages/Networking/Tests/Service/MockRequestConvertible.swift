//
// MockRequestConvertible.swift


import Foundation
@testable import Networking

final class MockRequestConvertible: NetworkingURLRequestConvertible {
    let urlRequest = URLRequest(url: URL(string: "www.example.com")!)
    
    func asURLRequest() throws -> URLRequest {
        return urlRequest
    }
}
