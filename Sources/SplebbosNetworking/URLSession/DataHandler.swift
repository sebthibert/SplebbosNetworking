import Combine
import Foundation

extension URLSession {
  func getDataIfNoErrors(_ output: DataTaskPublisher.Output) throws -> Data {
    try getDataIfNoErrors(output.data, output.response, nil)
  }

  func getDataIfNoErrors(
    _ data: Data?,
    _ response: URLResponse?,
    _ error: Error?
  ) throws -> Data {
    guard let data = data, error == nil else {
      throw URLSessionError.invalidResponse(data, nil, response)
    }
    try handleStatusCode(data, response)
    return data
  }

  private func handleStatusCode(_ data: Data, _ response: URLResponse?) throws {
    let httpURLResponse = try unwrap(optional: response as? HTTPURLResponse, orThrow: .invalidResponse(data, nil, response))
    let statusCode = httpURLResponse.statusCode
    let isFailedStatusCode = (200..<300).contains(statusCode) == false
    if isFailedStatusCode {
      throw URLSessionError.invalidResponse(data, statusCode, response)
    }
  }
}
