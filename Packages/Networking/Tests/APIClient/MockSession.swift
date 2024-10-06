//
// MockSession.swift

@testable import Alamofire
@testable import Networking

class MockSession: SessionType {
    var mockDataRequest: MockDataRequest?
    
    // Return the pre-configured mock data request
    func request(_ convertible: URLRequestConvertible) -> DataRequestType {
        return mockDataRequest ?? MockDataRequest()
    }
}
