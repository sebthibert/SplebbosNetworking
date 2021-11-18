import Foundation

struct StubCodable: Codable, Equatable {
  let id: Int
  let title: String

  init(id: Int = 0, title: String = "") {
    self.id = id
    self.title = title
  }
}
