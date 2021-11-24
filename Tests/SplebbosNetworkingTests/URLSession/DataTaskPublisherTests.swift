import Combine
@testable import SplebbosNetworking
import XCTest

final class DataTaskPublisherTests: XCTestCase {
  var cancellables: [AnyCancellable] = []

  func test_dataTaskPublisher_returnsData() throws {
    let expectation = XCTestExpectation(description: "Loading")
    let expectedData = Data("Cheese".utf8)
    let session = URLSession.mock(data: expectedData) { request in
      try HTTPURLResponse.mock(for: request.url, statusCode: 200)
    }
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
    let session = URLSession.mock(data: expectedData) { _ in
      URLResponse()
    }
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
    let response = try XCTUnwrap(publishedError?.response)
    XCTAssertFalse(response is HTTPURLResponse)
  }

  func test_dataTaskPublisher_failsIfNotSuccessfulStatusCode() throws {
    let expectation = XCTestExpectation(description: "Loading")
    let expectedData = Data("Cheese".utf8)
    let session = URLSession.mock(data: expectedData) { request in
      try HTTPURLResponse.mock(for: request.url, statusCode: 400)
    }
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

  func test_dataTaskPublisher_failsIfURLInvalid() throws {
    let expectation = XCTestExpectation(description: "Loading")
    let expectedData = Data("Cheese".utf8)
    let session = URLSession.mock(data: expectedData) { request in
      try HTTPURLResponse.mock(for: request.url, statusCode: 200)
    }
    let resource = Resource(host: "invalid", path: "invalid")
    let publisher: AnyPublisher<Data, Error> = session.dataTaskPublisher(for: resource)
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
    XCTAssertEqual(publishedError, .invalidURL)
  }
}
