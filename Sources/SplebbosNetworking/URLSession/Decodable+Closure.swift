import Foundation

public extension URLSession {
  func decodableTask<T: Decodable>(
    for resource: Resource,
    decoder: JSONDecoder = JSONDecoder(),
    completion: @escaping (Result<T, Swift.Error>) -> Void
  ) {
    dataTask(for: resource) { result in
      do {
        let decoded = try decoder.decode(T.self, from: try result.get())
        completion(.success(decoded))
      } catch {
        completion(.failure(error))
      }
    }
  }
}
