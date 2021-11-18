import Foundation

public extension URLSession {
  enum DataTaskError: Error, Equatable {
    case invalidResponse(Data?, Int?, URLResponse)

    var statusCode: Int? {
      switch self {
      case .invalidResponse(_, let statusCode, _):
        return statusCode
      }
    }

    var response: URLResponse {
      switch self {
      case .invalidResponse(_, _, let response):
        return response
      }
    }
  }
}
