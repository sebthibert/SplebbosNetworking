import Foundation

public extension URLRequest {
  init(resource: Resource) throws {
    let url = try URL(resource: resource)
    var request = URLRequest(url: url)
    resource.httpHeaderFields.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
    request.httpBody = resource.body
    self = request
  }
}
