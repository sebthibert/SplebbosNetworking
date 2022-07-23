import Combine
import Foundation

public extension URLSession {
  func decodablePublisher<T: Decodable>(for resource: Resource, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, Swift.Error> {
    dataTaskPublisher(for: resource)
      .decode(type: T.self, decoder: decoder)
      .eraseToAnyPublisher()
  }
}
