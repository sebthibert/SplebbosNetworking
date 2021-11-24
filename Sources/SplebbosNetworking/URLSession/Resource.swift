import Foundation

public struct Resource {
  public let scheme: String
  public let host: String
  public let path: String
  public let queryItems: [URLQueryItem]?
  public let percentEncodedQueryItems: [URLQueryItem]?
  public let httpHeaderFields: [String: String]
  public let body: Data?

  public init(
    scheme: String = "https",
    host: String,
    path: String,
    queryItems: [URLQueryItem]? = nil,
    percentEncodedQueryItems: [URLQueryItem]? = nil,
    httpHeaderFields: [String: String] = [:],
    body: Data? = nil
  ) {
    self.scheme = scheme
    self.host = host
    self.path = path
    self.queryItems = queryItems
    self.percentEncodedQueryItems = percentEncodedQueryItems
    self.httpHeaderFields = httpHeaderFields
    self.body = body
  }

  public func url() throws -> URL {
    try URL(resource: self)
  }

  public func request() throws -> URLRequest {
    try URLRequest(resource: self)
  }
}
