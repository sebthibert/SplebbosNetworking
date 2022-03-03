import Foundation

public extension JSONDecoder {
  static let decoderWith: (KeyDecodingStrategy, String?) -> JSONDecoder = { keyDecodingStrategy, dateFormat in
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = keyDecodingStrategy
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dateFormat
    decoder.dateDecodingStrategy = .formatted(dateFormatter)
    return decoder
  }
}
