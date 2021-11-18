import Combine
import Foundation

extension URLSession {
  func decodablePublisher<T: Decodable>(for request: URLRequest, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, Error> {
    dataTaskPublisher(for: request)
      .decode(type: T.self, decoder: decoder)
      .eraseToAnyPublisher()
  }
}
