import Combine
@testable import SplebbosNetworking
import XCTest

final class DataTaskPublisherTests: XCTestCase {
  var cancellables: [AnyCancellable] = []

  func test_dataTaskPublisher_returnsData() throws {
    let expectation = XCTestExpectation(description: "Loading")
    let expectedData = Data("Cheese".utf8)
    MockURLProtocol.requestHandler = { request in
      let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
      return (response, expectedData, nil)
    }

    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [MockURLProtocol.self]
    let session = URLSession(configuration: configuration)
    let publisher: AnyPublisher<Data, Error> = session.dataTaskPublisher(for: Resource.stub)
    var publishedData: Data?
    publisher
      .sink(
        receiveCompletion: { completion in
          expectation.fulfill()
        },
        receiveValue: { data in
          publishedData = data
        }
      )
      .store(in: &cancellables)
    wait(for: [expectation], timeout: 1)
    XCTAssertEqual(publishedData, expectedData)
  }

  func test_dataTaskPublisher_failsIfResponseIsNotHTTPURLResponse() throws {
    let expectation = XCTestExpectation(description: "Loading")
    let expectedData = Data("Cheese".utf8)
    MockURLProtocol.requestHandler = { request in
      let response = URLResponse()
      return (response, expectedData, nil)
    }

    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [MockURLProtocol.self]
    let session = URLSession(configuration: configuration)
    let publisher: AnyPublisher<Data, Error> = session.dataTaskPublisher(for: Resource.stub)
    var publishedError: URLSession.DataTaskError?
    publisher
      .sink(
        receiveCompletion: { completion in
          if case let .failure(error) = completion {
            publishedError = error as? URLSession.DataTaskError
          }
          expectation.fulfill()
        },
        receiveValue: { _ in }
      )
      .store(in: &cancellables)
    wait(for: [expectation], timeout: 1)
    XCTAssertFalse(publishedError?.response is HTTPURLResponse)
  }

  func test_dataTaskPublisher_failsIfNotSuccessfulStatusCode() throws {
    let expectation = XCTestExpectation(description: "Loading")
    let expectedData = Data("Cheese".utf8)
    MockURLProtocol.requestHandler = { request in
      let response = HTTPURLResponse(url: request.url!, statusCode: 400, httpVersion: nil, headerFields: nil)!
      return (response, expectedData, nil)
    }

    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [MockURLProtocol.self]
    let session = URLSession(configuration: configuration)
    let publisher: AnyPublisher<Data, Error> = session.dataTaskPublisher(for: Resource.stub)
    var publishedError: URLSession.DataTaskError?
    publisher
      .sink(
        receiveCompletion: { completion in
          if case let .failure(error) = completion {
            publishedError = error as? URLSession.DataTaskError
          }
          expectation.fulfill()
        },
        receiveValue: { _ in }
      )
      .store(in: &cancellables)
    wait(for: [expectation], timeout: 1)
    XCTAssertEqual(publishedError?.statusCode, 400)
  }
}
