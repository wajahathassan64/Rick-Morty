//
// HTTPURLResponse+Result.swift


import Foundation

enum ResponseResult<T> {
    case success
    case failure(T)
}

extension HTTPURLResponse {
    var result: ResponseResult<AppError> {
        if (200...299).contains(statusCode) {
            return .success
        } else {
            return .failure(AppError(HTTPURLResponse.localizedString(forStatusCode: self.statusCode), status: self.statusCode))
        }
    }
}
