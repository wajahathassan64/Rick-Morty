//
// MockAPIClient.swift


import Foundation
@testable import Networking

final class MockAPIClient: APIClientType {
    var completionForRequest: (code: Int, data: Data) = (-1, Data())
    
    func request(route: NetworkingURLRequestConvertible,
                 completion: @escaping RequestCompletionHandler) {
        completion(completionForRequest.code, completionForRequest.data)
    }
}
