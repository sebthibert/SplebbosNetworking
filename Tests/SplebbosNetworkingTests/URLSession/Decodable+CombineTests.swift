import Combine
import SplebbosNetworking
import SplebbosNetworkingMocks
import XCTest

final class DecodableAsyncTests: XCTestCase {
  func test_decodable_returnsDecodable() async throws {
    let expectedDecodable = StubCodable()
    let expectedData = try JSONEncoder().encode(expectedDecodable)
    let session = URLSession.mock(data: expectedData) { request in
      HTTPURLResponse.mock(for: request.url, statusCode: 200)
    }
    let decodable: StubCodable = try await session.decodable(for: .stub)
    XCTAssertEqual(decodable, expectedDecodable)
  }

  func test_decodable_throwsError() async throws {
    let expectedDecodable = StubCodable()
    let expectedData = try JSONEncoder().encode(expectedDecodable)
    let statusCode = 400
    let session = URLSession.mock(data: expectedData) { request in
      HTTPURLResponse.mock(for: request.url, statusCode: statusCode)
    }
    do {
      let _: StubCodable = try await session.decodable(for: .stub)
      XCTFail()
    } catch {
      if case let URLSession.URLSessionError.invalidResponse(data, status, response) = error {
        XCTAssertEqual(status, 400)
        XCTAssertEqual(data, expectedData)
      } else {
        XCTFail()
      }
    }
  }
}

final class DecodablePublisherTests: XCTestCase {
  var cancellables: [AnyCancellable] = []

  func test_decodablePublisher_returnsDecodable() throws {
    let expectation = XCTestExpectation(description: "Loading")
    let expectedDecodable = StubCodable()
    let expectedData = try JSONEncoder().encode(expectedDecodable)
    let session = URLSession.mock(data: expectedData) { request in
      HTTPURLResponse.mock(for: request.url, statusCode: 200)
    }
    let publisher: AnyPublisher<StubCodable, Error> = session.decodablePublisher(for: .stub)
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
      HTTPURLResponse.mock(for: request.url, statusCode: 200)
    }
    let publisher: AnyPublisher<String, Error> = session.decodablePublisher(for: .stub)
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
