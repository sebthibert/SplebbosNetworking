import Combine
import Foundation

public extension URLSession {
  func handleStatusCode(_ output: DataTaskPublisher.Output) throws -> DataTaskPublisher.Output {
    let response = output.response
    let httpURLResponse = try unwrap(optional: response as? HTTPURLResponse, orThrow: .invalidResponse(output.data, nil, response))
    let statusCode = httpURLResponse.statusCode
    guard (200..<300).contains(statusCode) else {
      throw DataTaskError.invalidResponse(output.data, statusCode, output.response)
    }
    return output
  }
}
