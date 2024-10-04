//
// APIClient.swift


import Alamofire
import Foundation

public typealias NetworkingURLRequestConvertible = URLRequestConvertible
public typealias NetworkingHTTPMethod = HTTPMethod
public typealias RequestCompletionHandler = (_ code: Int, _ data: Data) -> Void

public protocol APIClientType {
    func request(
        route: NetworkingURLRequestConvertible,
        completion: @escaping RequestCompletionHandler
    )
}

public class APIClient: APIClientType {
    
    private let session: Session
    
    init(session: Session = Session()) {
        self.session = session
    }
    
    public func request(route: NetworkingURLRequestConvertible, completion: @escaping RequestCompletionHandler) {
        session.request(route).validate().responseData { responseData in
            if let error = responseData.error {
                if let response = responseData.response, let data = responseData.data {
                    completion(response.statusCode, data)
                    return
                } else {
                    let nsError = error as NSError
                    completion(nsError.code, Data())
                    return
                }
            } else {
                if let response = responseData.response, let data = responseData.data {
                    completion(response.statusCode, data)
                    return
                }
            }
        }
    }
}
