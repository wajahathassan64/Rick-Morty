//
// Service.swift


import Foundation

public typealias Success<T: Decodable> = (T) -> Void
public typealias Failure = (Error) -> Void

public protocol Service {
    func request<T: Decodable>(
        _ apiClient: APIClientType,
        route: NetworkingURLRequestConvertible,
        onSuccess successCompletion: @escaping Success<T>,
        onFailure failureCompletion: @escaping Failure
    )
}

public extension Service {
    func request<T: Decodable>(
        _ apiClient: APIClientType,
        route: NetworkingURLRequestConvertible,
        onSuccess successCompletion: @escaping Success<T>,
        onFailure failureCompletion: @escaping Failure
    ) {
        apiClient.request(route: route) { (code, response) in
            do {
                let t: T = try self.validateResponse(code: code, response: response)
                successCompletion(t)
            } catch let error {
                failureCompletion(error)
            }
        }
    }
}

private extension Service {
    func validateResponse<T: Decodable>(code: Int, response: Data) throws -> T {
        switch code {
        case 200...299:
            let jsonDecoder = JSONDecoder()
            let serverResponse = try jsonDecoder.decode(Response<T>.self, from: response)
            return serverResponse.result
        case -1009:
            throw NetworkingError.noInternet
        case -1001:
            throw NetworkingError.requestTimedOut
        default:
            throw NetworkingError.unknown
        }
    }
}
