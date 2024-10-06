//
// APIClientTest.swift


import Foundation

import XCTest
@testable import Alamofire
@testable import Networking

class APIClientTest: XCTestCase {
    
    var sut: APIClient!
    var session: MockSession!
    var route: MockRequestConvertible!
    
    override func setUp() {
        super.setUp()
        session = MockSession()
        route = MockRequestConvertible()
        sut = APIClient(session: session)
    }
    
    override func tearDown() {
        session = nil
        route = nil
        sut = nil
        super.tearDown()
    }
    
    func testApiClientSuccess() {
        let exp = expectation(description: "APIClient completes request")
        
        let mockDataRequest = MockDataRequest()
        mockDataRequest.shouldSucceed = true // Simulate success
        mockDataRequest.mockStatusCode = 200 // HTTP 200 OK
        mockDataRequest.mockData = Data("Successful response".utf8) // Custom mock data
        
        session.mockDataRequest = mockDataRequest
        
        sut.request(route: route) { code, data in
            XCTAssertEqual(code, 200)
            XCTAssertNotNil(data)
            XCTAssertEqual(String(data: data, encoding: .utf8), "Successful response")
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 0.1)
    }
    
    func testApiClientFailure() {
        let exp = expectation(description: "APIClient completes request with failure")
        
        let mockDataRequest = MockDataRequest()
        mockDataRequest.shouldSucceed = false // Simulate Failure
        mockDataRequest.mockStatusCode = 500 // HTTP 500 Internal Server Error
        mockDataRequest.mockError = AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 500))
        
        session.mockDataRequest = mockDataRequest
        
        sut.request(route: route) { code, data in
            XCTAssertEqual(code, 500)
            XCTAssertEqual(data.count, 0)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 0.1)
    }
    
}
