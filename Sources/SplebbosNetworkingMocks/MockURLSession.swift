import Foundation

public extension URLSession {
  static func mock(
    data: Data,
    error: Error? = nil,
    response: @escaping (URLRequest) -> URLResponse?
  ) -> URLSession {
    MockURLProtocol.requestHandler = { request in
      (response(request), data, error)
    }
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [MockURLProtocol.self]
    return URLSession(configuration: configuration)
  }
}
