import Foundation

public extension URL {
  /// Builds a URL with all the components
  /// - Parameters:
  ///     - scheme: The scheme subcomponent of the URL.
  ///     - host: The host subcomponent.
  ///     - path: The path subcomponent.
  ///     - queryItems: The query items subcomponent
  ///     - percentEncodedQueryItems: The percent encoded query items subcomponent.
  init(resource: Resource) throws {
    var components = URLComponents()
    components.scheme = resource.scheme
    components.host = resource.host
    components.path = resource.path
    components.queryItems = resource.queryItems
    components.percentEncodedQueryItems = resource.percentEncodedQueryItems
    if let url = components.url {
      self = url
    } else {
      throw URLSession.DataTaskError.invalidURL
    }
  }
}
