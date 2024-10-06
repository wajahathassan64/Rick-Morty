//
// MockDataRequest.swift

@testable import Alamofire
@testable import Networking
import XCTest

class MockDataRequest: DataRequestType {
    var shouldSucceed = true
    var mockStatusCode: Int = 200
    var mockData: Data = Data()
    var mockError: AFError?

    func responseData(completionHandler: @escaping (AFDataResponse<Data>) -> Void) -> Self {
        let urlResponse = HTTPURLResponse(
            url: URL(string: "https://mockurl.com")!,
            statusCode: mockStatusCode,
            httpVersion: nil,
            headerFields: nil
        )
        
        if shouldSucceed {
            // Simulate a success response
            let response = AFDataResponse<Data>(
                request: nil,
                response: urlResponse,
                data: mockData,
                metrics: nil,
                serializationDuration: 0,
                result: .success(mockData)
            )
            completionHandler(response)
        } else {
            // Simulate a failure response
            let response = AFDataResponse<Data>(
                request: nil,
                response: urlResponse,
                data: mockData,
                metrics: nil,
                serializationDuration: 0,
                result: .failure(mockError ?? AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: mockStatusCode)))
            )
            completionHandler(response)
        }
        return self
    }
}
