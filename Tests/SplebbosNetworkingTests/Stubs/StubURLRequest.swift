import Foundation
import XCTest

extension URLRequest {
  static func stub() throws -> URLRequest {
    URLRequest(url: try URL.stub())
  }
}
