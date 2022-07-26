import Foundation

public extension JSONDecoder {
  static let decoderWith: (KeyDecodingStrategy, DateDecodingStrategy) -> JSONDecoder = { keyDecodingStrategy, dateDecodingStrategy in
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = keyDecodingStrategy
    decoder.dateDecodingStrategy = dateDecodingStrategy
    return decoder
  }
}
