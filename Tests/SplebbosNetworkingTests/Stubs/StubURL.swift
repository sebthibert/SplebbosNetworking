import Foundation
import XCTest

extension URL {
  static func stub() throws -> URL {
    try XCTUnwrap(URL(string: "https://www.google.com/"))
  }
}
