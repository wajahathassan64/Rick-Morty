//
// ConvertibleTests.swift


import Foundation
import XCTest
@testable import Networking

class ConvertibleTests: XCTestCase {
    
    var sut: Convertible!
    
    
    override func setUp() {
        super.setUp()
        sut = mockConvertible()
    }
    
    
    // MARK: - Tear down
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testUrlRequest_whenInputIsNil_shouldConstructUrl() throws {
        
        let url = URL(string: "https://www.rickmortty.com")!
        let path = "abc"
        let input: RouterInput<Int>? = nil
        
        let request = try sut.urlRequest(
            with: url,
            path: path,
            method: .get,
            requestType: .json,
            input: input
        )
        
        XCTAssertEqual(request.url?.absoluteString, "https://www.rickmortty.com/abc")
    }
    
    func testUrlRequest_whenInputContainsQuery_shouldConstructUrlWithQuery() throws {
        
        let url = URL(string: "https://www.rickmortty.com")!
        let path = "abc"
        let input = RouterInput<[String: String]>(body: nil, query: ["key": "value"], pathVariables: nil)
        
        let request = try sut.urlRequest(
            with: url,
            path: path,
            method: .get,
            requestType: .json,
            input: input
        )
        
        XCTAssertEqual(request.url?.absoluteString, "https://www.rickmortty.com/abc?key=value")
    }
    
    func testUrlRequestWithAllTypeInputs() throws {
        // given
        let url =  URL(string: "www.example.com/")!
        let path = "unit/testing"
        let method: NetworkingHTTPMethod = .get
        let requestType: NetworkingRequestType = .json
        let query = ["query": "test"]
        let body = ["someKey": "someValue"]
        let input: RouterInput<[String: String]> = (body: body, query: query, pathVariables: ["somepath"])
        
        // when
        let request = try sut.urlRequest(
            with: url,
            path: path,
            method: method,
            requestType: requestType,
            input: input
        )
        
        // then
        XCTAssertEqual(request.method, method)
        XCTAssertEqual(request.url?.absoluteString, "www.example.com/unit/testing/somepath?query=test")
        let decoded = try? JSONDecoder().decode([String: String].self, from: (request.httpBody)!)
        XCTAssertEqual(decoded?["someKey"], "someValue")
    }
}

struct mockConvertible: Convertible { }
