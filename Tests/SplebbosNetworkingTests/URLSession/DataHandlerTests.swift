import Combine
@testable import SplebbosNetworking
import XCTest

final class DataHandlerTests: XCTestCase {
  func test_getDataIfNoErrors_returnsData_whenNoErrors() throws {
    let response = try XCTUnwrap(HTTPURLResponse(url: try Resource.stub.url(), statusCode: 200, httpVersion: nil, headerFields: nil))
    let data = Data()
    let expectedData = try URLSession.shared.getDataIfNoErrors(data, response, nil)
    XCTAssertEqual(expectedData, data)
  }

  func test_getDataIfNoErrors_throws_whenHasNoData() {
    let response = URLResponse()
    do {
      _ = try URLSession.shared.getDataIfNoErrors(nil, response, nil)
    } catch {
      let dataError = error as? URLSession.URLSessionError
      XCTAssertEqual(dataError,  URLSession.URLSessionError.invalidResponse(nil, nil, response))
    }
  }

  func test_getDataIfNoErrors_throws_whenHasError() {
    let data = Data()
    let response = URLResponse()
    do {
      _ = try URLSession.shared.getDataIfNoErrors(data, response, URLSession.URLSessionError.invalidURL)
    } catch {
      let dataError = error as? URLSession.URLSessionError
      XCTAssertEqual(dataError,  URLSession.URLSessionError.invalidResponse(data, nil, response))
    }
  }

  func test_getDataIfNoErrors_throws_whenResponseIsNotHTTPURLResponse() {
    let data = Data()
    let response = URLResponse()
    do {
      _ = try URLSession.shared.getDataIfNoErrors(data, response, nil)
    } catch {
      let dataError = error as? URLSession.URLSessionError
      XCTAssertEqual(dataError,  URLSession.URLSessionError.invalidResponse(data, nil, response))
    }
  }

  func test_getDataIfNoErrors_throws_whenStatusCodeIsNotSuccessful() throws {
    let data = Data()
    let statusCode = 400
    let response = try XCTUnwrap(HTTPURLResponse(url: try Resource.stub.url(), statusCode: statusCode, httpVersion: nil, headerFields: nil))
    do {
      _ = try URLSession.shared.getDataIfNoErrors(data, response, nil)
    } catch {
      let dataTaskError = error as? URLSession.URLSessionError
      XCTAssertEqual(dataTaskError, URLSession.URLSessionError.invalidResponse(data, statusCode, response))
    }
  }
}
