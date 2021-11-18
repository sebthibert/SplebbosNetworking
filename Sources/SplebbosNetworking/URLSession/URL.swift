import Foundation

public extension URL {
  /// Builds a URL with all the components
  /// - Parameters:
  ///     - scheme: The scheme subcomponent of the URL.
  ///     - host: The host subcomponent.
  ///     - path: The path subcomponent.
  ///     - queryItems: The query items subcomponent
  ///     - percentEncodedQueryItems: The percent encoded query items subcomponent.
  init?(
    scheme: String,
    host: String,
    path: String,
    queryItems: [URLQueryItem]? = nil,
    percentEncodedQueryItems: [URLQueryItem]? = nil
  ) {
    var components = URLComponents()
    components.scheme = scheme
    components.host = host
    components.path = path
    components.queryItems = queryItems
    components.percentEncodedQueryItems = percentEncodedQueryItems
    if let url = components.url {
      self = url
    } else {
      return nil
    }
  }
}
