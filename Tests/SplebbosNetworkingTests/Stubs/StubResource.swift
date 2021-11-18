import Foundation
import SplebbosNetworking
import XCTest

extension Resource {
  static func stub() -> Resource {
    Resource(host: "www.google.com", path: "/")
  }
}
