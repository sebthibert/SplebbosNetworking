import Combine
import Foundation

extension URLSession {
  func handleStatusCode(_ output: DataTaskPublisher.Output) throws -> DataTaskPublisher.Output {
    guard let httpURLResponse = output.response as? HTTPURLResponse else {
      throw DataTaskError.invalidResponse(output.data, nil, output.response)
    }
    let statusCode = httpURLResponse.statusCode
    guard (200..<300).contains(statusCode) else {
      throw DataTaskError.invalidResponse(output.data, statusCode, output.response)
    }
    return output
  }
}
