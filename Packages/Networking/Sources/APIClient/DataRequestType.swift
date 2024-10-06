//
// DataRequestType.swift

import Foundation
import Alamofire

public protocol DataRequestType {
    @discardableResult
    func responseData(completionHandler: @escaping (AFDataResponse<Data>) -> Void) -> Self
}

// Wrapper for Alamofire's DataRequest to conform to DataRequestType
public class DataRequestWrapper: DataRequestType {
    private let dataRequest: DataRequest
    
    init(dataRequest: DataRequest) {
        self.dataRequest = dataRequest
    }
    
    @discardableResult
    public func responseData(completionHandler: @escaping (AFDataResponse<Data>) -> Void) -> Self {
        dataRequest.responseData(completionHandler: completionHandler)
        return self
    }
}


