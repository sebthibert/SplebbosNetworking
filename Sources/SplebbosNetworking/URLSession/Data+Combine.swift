import Combine
import Foundation

public extension URLSession {
  func dataTaskPublisher(for resource: Resource) -> AnyPublisher<Data, Swift.Error> {
    do {
      return dataTaskPublisher(for: try resource.request())
        .tryMap { try self.getDataIfNoErrors($0) }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    } catch {
      return Fail(error: error)
        .eraseToAnyPublisher()
    }
  }
}
