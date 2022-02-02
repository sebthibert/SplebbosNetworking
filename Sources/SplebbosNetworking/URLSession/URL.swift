import Foundation

public extension URL {
  /// Builds a URL with all the components
  /// - Parameters:
  ///     - resource: The resource containing the URL components.
  init(resource: Resource) throws {
    var components = URLComponents()
    components.scheme = resource.scheme
    components.host = resource.host
    components.path = resource.path
    components.percentEncodedQueryItems = resource.percentEncodedQueryItems
    self = try unwrap(optional: components.url, orThrow: URLSession.DataTaskError.invalidURL)
  }
}
