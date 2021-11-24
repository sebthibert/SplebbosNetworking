import Foundation

public extension HTTPURLResponse {
  static func mock(
    for url: URL?,
    statusCode: Int,
    httpVersion: String? = nil,
    headerFields: [String: String]? = nil
  ) -> HTTPURLResponse? {
    guard let url = url else {
      return nil
    }
    guard let response = HTTPURLResponse(
      url: url,
      statusCode: statusCode,
      httpVersion: httpVersion,
      headerFields: headerFields
    ) else {
      return nil
    }
    return response
  }
}
