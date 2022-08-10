import Foundation

public extension URLSession {
  func decodable<T: Decodable>(for resource: Resource, decoder: JSONDecoder = JSONDecoder()) async throws -> T {
    let data = try await data(for: resource)
    return try decoder.decode(T.self, from: data)
  }
}
