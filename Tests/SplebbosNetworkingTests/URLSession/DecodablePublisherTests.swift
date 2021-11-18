import Combine
@testable import SplebbosNetworking
import XCTest

final class DecodablePublisherTests: XCTestCase {
  var cancellables: [AnyCancellable] = []

  func test_decodablePublisher_returnsDecodable() throws {
    let expectation = XCTestExpectation(description: "Loading")
    let expectedDecodable = StubCodable()
    let expectedData = try JSONEncoder().encode(expectedDecodable)
    MockURLProtocol.requestHandler = { request in
      let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
      return (response, expectedData, nil)
    }

    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [MockURLProtocol.self]
    let session = URLSession(configuration: configuration)
    let publisher: AnyPublisher<StubCodable, Error> = session.decodablePublisher(for: try URLRequest.stub())
    var publishedDecodable: StubCodable?
    publisher
      .sink(
        receiveCompletion: { completion in
          expectation.fulfill()
        },
        receiveValue: { decodable in
          publishedDecodable = decodable
        }
      )
      .store(in: &cancellables)
    wait(for: [expectation], timeout: 1)
    XCTAssertEqual(publishedDecodable, expectedDecodable)
  }

  func test_dataTaskPublisher_failsIfResponseIsNotHTTPURLResponse() throws {
    let expectation = XCTestExpectation(description: "Loading")
    let expectedDecodable = StubCodable()
    let expectedData = try JSONEncoder().encode(expectedDecodable)
    MockURLProtocol.requestHandler = { request in
      let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
      return (response, expectedData, nil)
    }

    let configuration = URLSessionConfiguration.ephemeral
    configuration.protocolClasses = [MockURLProtocol.self]
    let session = URLSession(configuration: configuration)
    let publisher: AnyPublisher<StubCodable, Error> = session.decodablePublisher(for: try URLRequest.stub())
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
}
