import Foundation

public struct Resource {
  let scheme: String
  let host: String
  let path: String
  let queryItems: [URLQueryItem]?
  let percentEncodedQueryItems: [URLQueryItem]?
  let httpHeaderFields: [String: String]
  let body: Data?

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

  func url() throws -> URL {
    try URL(resource: self)
  }

  func request() throws -> URLRequest {
    try URLRequest(resource: self)
  }
}
