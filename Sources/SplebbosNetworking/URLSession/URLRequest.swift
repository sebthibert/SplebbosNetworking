import Foundation

public extension URLRequest {
  init<T: Encodable>(
    url: URL,
    httpHeaderFields: [String: String] = [:],
    body: T? = nil,
    encoder: JSONEncoder? = nil
  ) {
    var request = URLRequest(url: url)
    httpHeaderFields.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
    request.httpBody = try? encoder?.encode(body)
    self = request
  }
}
