import Foundation

public enum HTTPMethod {
  case `get`
  case post(Data?)

  public var rawValue: String {
    switch self {
    case .get:
      return "GET"
    case .post:
      return "POST"
    }
  }

}
