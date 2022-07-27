import Foundation

public extension URLSession {
  func decodable<T: Decodable>(
    for resource: Resource,
    decoder: JSONDecoder = JSONDecoder()
  ) async -> Result<T, Error> {
    do {
      let data = try await data(for: resource)
      let decoded = try decoder.decode(T.self, from: data)
      return .success(decoded)
    } catch {
      return .failure(error)
    }
  }
}
