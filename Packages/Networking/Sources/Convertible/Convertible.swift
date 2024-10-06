//
// Convertible.swift


import Foundation

public protocol Convertible {
    func urlRequest<T: Encodable>(
        with url: URL,
        path: String,
        method: NetworkingHTTPMethod,
        requestType: NetworkingRequestType,
        input: RouterInput<T>?
    ) throws -> URLRequest
}

public extension Convertible {
    func urlRequest<T: Encodable>(
        with url: URL,
        path: String,
        method: NetworkingHTTPMethod,
        requestType: NetworkingRequestType = .json,
        input: RouterInput<T>?
    ) throws -> URLRequest {
        let url = constructAPIUrl(
            with: url,
            path: path,
            input: input
        )
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        
        requestType.requestHeaders.forEach { (key, value) in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        guard let body = input?.body else { return urlRequest }
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .millisecondsSince1970
        urlRequest.httpBody = try encoder.encode(body)

        return urlRequest
    }
        
    private func constructAPIUrl<T: Encodable>(
        with url: URL,
        path: String,
        input: RouterInput<T>?
    ) -> URL {
        var constructedURL = url.appendingPathComponent(path)
        
        guard let input = input else {
            return constructedURL
        }
        
        input.pathVariables?.forEach {
            constructedURL.appendPathComponent($0)
        }
        
        guard let query = input.query,
            var components =  URLComponents(string: constructedURL.absoluteString)
            else { return constructedURL }
        
        components.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        
        return components.url ?? constructedURL
    }
}

