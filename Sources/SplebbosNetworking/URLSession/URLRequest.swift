import Foundation

public extension URLRequest {
  init(
    scheme: String = "https",
    host: String,
    path: String,
    queryItems: [URLQueryItem]? = nil,
    percentEncodedQueryItems: [URLQueryItem]? = nil,
    httpHeaderFields: [String: String] = [:],
    body: Data? = nil
  ) throws {
    let url = try URL(
      scheme: scheme,
      host: host,
      path: path
    )
    var request = URLRequest(url: url)
    httpHeaderFields.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
    request.httpBody = body
    self = request
  }
}
