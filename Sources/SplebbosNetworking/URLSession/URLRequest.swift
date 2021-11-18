import Foundation

public extension URLRequest {
  init<T: Encodable>(
    scheme: String = "https",
    host: String,
    path: String,
    queryItems: [URLQueryItem]? = nil,
    percentEncodedQueryItems: [URLQueryItem]? = nil,
    httpHeaderFields: [String: String] = [:],
    body: T? = nil,
    encoder: JSONEncoder? = nil
  ) throws {
    let url = try URL(
      scheme: scheme,
      host: host,
      path: path
    )
    var request = URLRequest(url: url)
    httpHeaderFields.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
    request.httpBody = try? encoder?.encode(body)
    self = request
  }
}
