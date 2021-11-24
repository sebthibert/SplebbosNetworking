import Foundation

public func unwrap<T>(optional: T?, orThrow error: URLSession.DataTaskError) throws -> T {
  if let unwrapped = optional {
    return unwrapped
  } else {
    throw error
  }
}
