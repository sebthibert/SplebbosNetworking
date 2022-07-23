import Foundation

public extension URLSession {
  func data(for resource: Resource) async throws -> Data {
    let (data, response) = try await data(from: try resource.url())
    return try getDataIfNoErrors(data, response, nil)
  }
}

