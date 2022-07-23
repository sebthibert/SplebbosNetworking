@testable import SplebbosNetworking
import XCTest

final class DataTaskErrorTests: XCTestCase {
  func test_invalidResponse_statusCode_whenHasNoStatusCode() {
    let error: URLSession.Error = .invalidResponse(nil, nil, URLResponse())
    XCTAssertNil(error.statusCode)
  }

  func test_invalidResponse_statusCode_whenHasStatusCode() {
    let statusCode = 200
    let error: URLSession.Error = .invalidResponse(nil, statusCode, URLResponse())
    XCTAssertEqual(error.statusCode, statusCode)
  }

  func test_invalidResponse_response() {
    let response = URLResponse()
    let error: URLSession.Error = .invalidResponse(nil, nil, response)
    XCTAssertEqual(error.response, response)
  }

  func test_invalidURL_statusCode() {
    let error: URLSession.Error = .invalidURL
    XCTAssertNil(error.statusCode)
  }

  func test_invalidURL_response() {
    let error: URLSession.Error = .invalidURL
    XCTAssertNil(error.response)
  }
}
