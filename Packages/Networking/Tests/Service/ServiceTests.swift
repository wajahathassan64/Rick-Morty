//
// ServiceTests.swift


import XCTest
@testable import Networking

final class ServiceTests: XCTestCase {
    
    var sut: Service!
    var apiClient: MockAPIClient!
    var requestConvertible: MockRequestConvertible!
    
    struct TestService: Service {}
    
    override func setUp() {
        super.setUp()
        
        sut = TestService()
        apiClient = MockAPIClient()
        requestConvertible = MockRequestConvertible()
    }
    
    override func tearDown() {
        sut = nil
        apiClient = nil
        requestConvertible = nil
        super.tearDown()
    }
    
    func testRequest_withSuccessResponse() {
        
        let mockData = MockServiceData(code: 123, data: "Testing")
        let data = (try? JSONEncoder().encode(mockData))!
        var apiResponse: MockServiceData?
        apiClient.completionForRequest = (code: 200, data: data)
        
        let responseExpectation = expectation(description: "API responded back")
        
        let success: Success<MockServiceData> = { response in
            apiResponse = response
            responseExpectation.fulfill()
        }
        
        // when
        sut.request(apiClient, route: requestConvertible, onSuccess: success, onFailure: { _ in })
        
        wait(for: [responseExpectation], timeout: 0.1)
        XCTAssertEqual(apiResponse?.code, mockData.code)
        XCTAssertEqual(apiResponse?.data, mockData.data)
    }
    
    func testRequest_withFailureResponse() {
        // given
        apiClient.completionForRequest = (code: 400, data: Data())
        let responseExpectation = expectation(description: "API responded back")
        let success: Success<MockServiceData> = { _ in }
        let failure: Failure = { _ in
            responseExpectation.fulfill()
        }
        
        // when
        sut.request(apiClient, route: requestConvertible, onSuccess: success, onFailure: failure)
        
        // then
        wait(for: [responseExpectation], timeout: 1.0)
    }
    
}   


private extension ServiceTests {
    struct MockServiceData: Codable {
        let code: Int
        let data: String
    }
}
