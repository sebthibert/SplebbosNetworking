import Foundation

public extension URLSession {
  static func mock(
    data: Data,
    error: Error? = nil,
    response: @escaping (URLRequest) throws -> URLResponse
  ) -> URLSession {
    MockURLProtocol.requestHandler = { request in
      (try response(request), data, error)
    }
    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [MockURLProtocol.self]
    return URLSession(configuration: configuration)
  }
}
