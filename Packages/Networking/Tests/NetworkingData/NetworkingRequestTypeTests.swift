//
// NetworkingRequestTypeTests.swift


import XCTest
@testable import Networking

final class NetworkingRequestTypeTests: XCTestCase {
    // MARK: - Tests
    func testJsonRequestHeaders() {
        // given
        let requestType: NetworkingRequestType = .json
        
        // when
        let headers = requestType.requestHeaders
        
        // then
        XCTAssertEqual(headers["Content-Type"], "application/json")
        XCTAssertEqual(headers["Accept"], "application/json")
    }
    
    func testJsonRequestHeadersCount() {
        // given
        let requestType: NetworkingRequestType = .json
        
        // when
        let headers = requestType.requestHeaders
        
        // then
        XCTAssertEqual(headers.count, 2, "There should be exactly 2 headers for JSON request type.")
    }
}

