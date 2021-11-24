import Foundation
import XCTest

public extension HTTPURLResponse {
  static func mock(
    for url: URL?,
    statusCode: Int,
    httpVersion: String? = nil,
    headerFields: [String: String]? = nil
  ) throws -> HTTPURLResponse {
    let response = HTTPURLResponse(
      url: try XCTUnwrap(url),
      statusCode: statusCode,
      httpVersion: httpVersion,
      headerFields: headerFields
    )
    return try XCTUnwrap(response)
  }
}
