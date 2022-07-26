import Foundation

public struct Resource {
  public let scheme: String?
  public let httpMethod: HTTPMethod
  public let host: String?
  public let path: String
  public let percentEncodedQueryItems: [URLQueryItem]?
  public let httpHeaderFields: [String: String]?
  public let cachePolicy: URLRequest.CachePolicy

  public init(
    scheme: String? = "https",
    httpMethod: HTTPMethod = .get,
    host: String?,
    path: String = "/",
    percentEncodedQueryItems: [URLQueryItem]? = nil,
    httpHeaderFields: [String: String]? = [:],
    cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
  ) {
    self.scheme = scheme
    self.httpMethod = httpMethod
    self.host = host
    self.path = path
    self.percentEncodedQueryItems = percentEncodedQueryItems
    self.httpHeaderFields = httpHeaderFields
    self.cachePolicy = cachePolicy
  }

  public func url() throws -> URL {
    try URL(resource: self)
  }

  public func request() throws -> URLRequest {
    try URLRequest(resource: self)
  }
}
