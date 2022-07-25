import Foundation

public extension URLRequest {
  init(resource: Resource) throws {
    let url = try URL(resource: resource)
    var request = URLRequest(url: url)
    request.httpMethod = resource.httpMethod.rawValue
    if case .post(let data) = resource.httpMethod {
      request.httpBody = data
    }
    resource.httpHeaderFields?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
    self = request
  }
}
