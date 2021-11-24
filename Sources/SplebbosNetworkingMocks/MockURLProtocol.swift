import Foundation

public final class MockURLProtocol: URLProtocol {
  public override class func canInit(with request: URLRequest) -> Bool {
    return true
  }

  public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
  }

  static var requestHandler: ((URLRequest) throws -> (URLResponse, Data?, Error?))?

  public override func startLoading() {
    let handler = try? MockURLProtocol.requestHandler?(request)
    if let response = handler?.0, let data = handler?.1 {
      client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
      client?.urlProtocol(self, didLoad: data)
      client?.urlProtocolDidFinishLoading(self)
    } else if let error = handler?.2 {
      client?.urlProtocol(self, didFailWithError: error)
    }
  }

  public override func stopLoading() {}
}
