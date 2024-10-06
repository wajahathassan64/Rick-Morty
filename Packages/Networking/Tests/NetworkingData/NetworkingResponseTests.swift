//
// NetworkingResponseTests.swift


import XCTest
@testable import Networking

final class NetworkingResponseTests: XCTestCase {
    // MARK: - Mocks
    struct MockDecodable: Decodable, Equatable {
        let name: String
        let age: Int
    }
    
    // Helper method to decode the response from JSON data
    func decodeResponse<T: Decodable>(json: String, to type: T.Type) throws -> Response<T> {
        let jsonData = Data(json.utf8)
        let decoder = JSONDecoder()
        return try decoder.decode(Response<T>.self, from: jsonData)
    }
    
    // MARK: - Tests
    func testResponseInit_withDecodable() throws {
        // given
        let name = "Bruce Wayne"
        let age = 30
        let expected = MockDecodable(name: name, age: age)
        let json = """
            {
                "name": "\(name)",
                "age": \(age)
            }
            """
        // when
        let response = try decodeResponse(json: json, to: MockDecodable.self)
        
        // then
        XCTAssertEqual(response.result, expected)
    }
}
