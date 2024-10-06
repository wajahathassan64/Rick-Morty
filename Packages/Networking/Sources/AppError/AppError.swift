//
// AppError.swift

import Foundation
public struct AppError: LocalizedError, Decodable {
    let message: String?
    let timestamp: String?
    let status: Int
    let error: String?
    
    public init(_ message: String,
                timestamp: String? = nil,
                status: Int = 0,
                error: String? = nil) {
        self.message = message
        self.timestamp = timestamp
        self.status = status
        self.error = error
    }
    
    public var errorDescription: String? {
        message
    }
}

