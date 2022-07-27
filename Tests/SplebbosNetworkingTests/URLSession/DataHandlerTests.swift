import Combine
@testable import SplebbosNetworking
import XCTest

final class DataHandlerTests: XCTestCase {
  func test_getDataIfNoErrors_returnsData_whenNoErrors() throws {
    let response = try XCTUnwrap(HTTPURLResponse(url: try Resource.stub.url(), statusCode: 200, httpVersion: nil, headerFields: nil))
    let startOutput = (data: Data(), response: response)
    let endOutput = try URLSession.shared.getDataIfNoErrors(startOutput)
    XCTAssertEqual(startOutput.data, endOutput)
  }

  func test_getDataIfNoErrors_throws_whenResponseIsNotHTTPURLResponse() {
    let response = URLResponse()
    let output = (data: Data(), response: response)
    do {
      _ = try URLSession.shared.getDataIfNoErrors(output)
    } catch {
      let dataTaskError = error as? URLSession.URLSessionError
      XCTAssertEqual(dataTaskError?.response, response)
    }
  }

  func test_getDataIfNoErrors_throws_whenStatusCodeIsNotSuccessful() {
    let statusCode = 400
    do {
      let response = try XCTUnwrap(HTTPURLResponse(url: try Resource.stub.url(), statusCode: statusCode, httpVersion: nil, headerFields: nil))
      let output = (data: Data(), response: response)
      _ = try URLSession.shared.getDataIfNoErrors(output)
    } catch {
      let dataTaskError = error as? URLSession.URLSessionError
      XCTAssertEqual(dataTaskError?.statusCode, statusCode)
    }
  }
}
