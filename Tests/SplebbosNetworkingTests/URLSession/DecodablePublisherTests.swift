import Combine
@testable import SplebbosNetworking
import XCTest

final class DecodablePublisherTests: XCTestCase {
  var cancellables: [AnyCancellable] = []

  func test_decodablePublisher_returnsDecodable() throws {
    let expectation = XCTestExpectation(description: "Loading")
    let expectedDecodable = StubCodable()
    let expectedData = try JSONEncoder().encode(expectedDecodable)
    let session = URLSession.mock(data: expectedData) { request in
      try HTTPURLResponse.mock(for: request.url, statusCode: 200)
    }
    let publisher: AnyPublisher<StubCodable, Error> = session.decodablePublisher(for: Resource.stub)
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

  func test_decodablePublisher_failsIfCannotDecode() throws {
    let expectation = XCTestExpectation(description: "Loading")
    let expectedDecodable = StubCodable()
    let expectedData = try JSONEncoder().encode(expectedDecodable)
    let session = URLSession.mock(data: expectedData) { request in
      try HTTPURLResponse.mock(for: request.url, statusCode: 200)
    }
    let publisher: AnyPublisher<String, Error> = session.decodablePublisher(for: Resource.stub)
    var publishedError: Error?
    publisher
      .sink(
        receiveCompletion: { completion in
          if case let .failure(error) = completion {
            publishedError = error
          }
          expectation.fulfill()
        },
        receiveValue: { _ in }
      )
      .store(in: &cancellables)
    wait(for: [expectation], timeout: 1)
    XCTAssertTrue(publishedError is DecodingError)
  }
}
