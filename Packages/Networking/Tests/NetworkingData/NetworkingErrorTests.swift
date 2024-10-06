//
// NetworkingErrorTests.swift

import XCTest
@testable import Networking

final class NetworkingErrorTests: XCTestCase {
    // MARK: - Tests
    func testNoInternetErrorDescription() {
        // when
        let error: NetworkingError = .noInternet
        
        // then
        XCTAssertEqual(error.localizedDescription, "Looks like you're not connect to internet!")
    }
    
    func testRequestTimedOutErrorDescription() {
        // when
        let error: NetworkingError = .requestTimedOut
        
        // then
        XCTAssertEqual(error.localizedDescription, "Looks like it's take too long to process your reqeust!")
    }
    
    func testUnknownErrorDescription() {
        // when
        let error: NetworkingError = .unknown
        
        // then
        XCTAssertEqual(error.localizedDescription, "Oops! something bad happened")
    }
    
}
