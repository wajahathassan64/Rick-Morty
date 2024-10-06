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
            
            let statusCode = self.getStatusCode(from: responseData)
            
            switch responseData.response?.result {
            case .success:
                if let response = responseData.response, let data = responseData.data {
                    completion(response.statusCode, data)
                    return
                }
            case .failure:
                completion(statusCode, Data())
                return
            case .none:
                completion(statusCode, Data())
            }
        }
    }
}

extension APIClient {
    private func getStatusCode(from dataResponse: AFDataResponse<Data>) -> Int {
        switch dataResponse.response?.result {
        case .none:
            return NSURLErrorNotConnectedToInternet
        case .failure, .success:
            return dataResponse.response?.statusCode ??
            (dataResponse.error?.underlyingError as NSError?)?.code ??
            (dataResponse.error as NSError?)?.code ??
            NSURLErrorNotConnectedToInternet
        }
    }
}
