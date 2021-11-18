import Combine
import Foundation

public extension URLSession {
  func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<Data, Error> {
    dataTaskPublisher(for: request)
      .tryMap { try self.handleStatusCode($0) }
      .map { $0.data }
      .eraseToAnyPublisher()
  }
}
