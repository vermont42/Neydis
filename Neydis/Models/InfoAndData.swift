// Copyright © 2024 Josh Adams. All rights reserved.

struct InfoAndData: Decodable {
  let info: Info
  let disChars: [DisChar]

  enum CodingKeys: String, CodingKey {
    case info
    case disChars = "data"
  }
}
