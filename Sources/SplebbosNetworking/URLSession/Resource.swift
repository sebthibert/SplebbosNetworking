import Foundation

public struct Resource {
  public let scheme: String?
  public let httpMethod: HTTPMethod
  public let host: String?
  public let path: String
  public let percentEncodedQueryItems: [URLQueryItem]?
  public let httpHeaderFields: [String: String]?

  public init(
    scheme: String? = "https",
    httpMethod: HTTPMethod = .get,
    host: String?,
    path: String = "/",
    percentEncodedQueryItems: [URLQueryItem]? = nil,
    httpHeaderFields: [String: String]? = [:]
  ) {
    self.scheme = scheme
    self.httpMethod = httpMethod
    self.host = host
    self.path = path
    self.percentEncodedQueryItems = percentEncodedQueryItems
    self.httpHeaderFields = httpHeaderFields
  }

  public func url() throws -> URL {
    try URL(resource: self)
  }

  public func request() throws -> URLRequest {
    try URLRequest(resource: self)
  }
}
