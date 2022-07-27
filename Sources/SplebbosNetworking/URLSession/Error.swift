import Foundation

public extension URLSession {
  enum URLSessionError: Error, Equatable {
    case invalidResponse(Data?, Int?, URLResponse?)
    case invalidURL

    var statusCode: Int? {
      switch self {
      case .invalidResponse(_, let statusCode, _):
        return statusCode
      case .invalidURL:
        return nil
      }
    }

    var response: URLResponse? {
      switch self {
      case .invalidResponse(_, _, let response):
        return response
      case .invalidURL:
        return nil
      }
    }
  }
}
