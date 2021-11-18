import Combine
import Foundation

public extension URLSession {
  func dataTaskPublisher(for resource: Resource) -> AnyPublisher<Data, Error> {
    do {
      return dataTaskPublisher(for: try resource.request())
        .tryMap { try self.handleStatusCode($0) }
        .map { $0.data }
        .eraseToAnyPublisher()
    } catch {
      return Fail(error: error)
        .eraseToAnyPublisher()
    }
  }
}
