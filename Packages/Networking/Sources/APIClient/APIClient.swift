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

public protocol SessionType {
    func request(_ convertible: URLRequestConvertible) -> DataRequestType
}

public class APIClient: APIClientType {
    
    let session: SessionType
    
    init(session: SessionType = SessionAdapter.default) {
        self.session = session
    }
    
    public func request(route: NetworkingURLRequestConvertible, completion: @escaping RequestCompletionHandler) {
        session.request(route).responseData { responseData in
            
            // Validate the response using the validate method
            if let validationError = self.validate(response: responseData) {
                let nsError = validationError as NSError
                completion(nsError.code, Data())
                return
            }
            
            // Handle successful response
            if let response = responseData.response, let data = responseData.data {
                completion(response.statusCode, data)
                return
            }
        }
    }
    
    // Validation function
    private func validate(response: AFDataResponse<Data>) -> AFError? {
        // Validate status codes
        if let statusCode = response.response?.statusCode {
            if !(200..<300).contains(statusCode) {
                return AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: statusCode))
            }
        }
        
        // Validate content type
        if let mimeType = response.response?.mimeType {
            if mimeType != "application/json" {
                return AFError.responseValidationFailed(reason: .unacceptableContentType(acceptableContentTypes: ["application/json"], responseContentType: mimeType))
            }
        }
        
        return nil
    }
}
