import Foundation

public extension URLSession {
  func dataTask(for resource: Resource, completionHandler: @escaping (Result<Data, Swift.Error>) -> Void) {
    do {
      let task = dataTask(with: try resource.request()) { data, response, error in
        do {
          let data = try self.getDataIfNoErrors(data, response, error)
          completionHandler(.success(data))
        } catch {
          completionHandler(.failure(error))
        }
      }
      task.resume()
    } catch {
      completionHandler(.failure(error))
    }
  }
}
