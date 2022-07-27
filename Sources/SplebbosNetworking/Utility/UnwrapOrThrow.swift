import Foundation

public func unwrap<T>(optional: T?, orThrow error: URLSession.URLSessionError) throws -> T {
  if let unwrapped = optional {
    return unwrapped
  } else {
    throw error
  }
}
