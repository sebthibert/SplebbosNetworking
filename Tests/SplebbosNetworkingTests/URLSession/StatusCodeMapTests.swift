import Combine
@testable import SplebbosNetworking
import XCTest

final class StatusCodeMapTests: XCTestCase {
  func test_handleStatusCode_returnsSameOuput() throws {
    let response = try XCTUnwrap(HTTPURLResponse(url: try Resource.stub.url(), statusCode: 200, httpVersion: nil, headerFields: nil))
    let startOutput = (data: Data(), response: response)
    let endOutput = try URLSession.shared.handleStatusCode(startOutput)
    XCTAssertEqual(startOutput.data, endOutput.data)
    XCTAssertEqual(startOutput.response, endOutput.response)
  }

  func test_handleStatusCode_throws_whenResponseIsNotHTTPURLResponse() {
    let response = URLResponse()
    let output = (data: Data(), response: response)
    do {
      _ = try URLSession.shared.handleStatusCode(output)
    } catch {
      let dataTaskError = error as? URLSession.DataTaskError
      XCTAssertEqual(dataTaskError?.response, response)
    }
  }

  func test_handleStatusCode_throws_whenStatusCodeIsNotSuccessful() {
    let statusCode = 400
    do {
      let response = try XCTUnwrap(HTTPURLResponse(url: try Resource.stub.url(), statusCode: statusCode, httpVersion: nil, headerFields: nil))
      let output = (data: Data(), response: response)
      _ = try URLSession.shared.handleStatusCode(output)
    } catch {
      let dataTaskError = error as? URLSession.DataTaskError
      XCTAssertEqual(dataTaskError?.statusCode, statusCode)
    }
  }
}
