// Copyright © 2024 Josh Adams. All rights reserved.

import Foundation

enum Loader {
  static let pageSize = 50

  static func loadInfoAndData(page: Int) async -> InfoAndData? {
    guard let url = URL(string: "https://api.disneyapi.dev/character?page=\(page)") else {
      return nil
    }

    do {
      let (jsonData, _) = try await URLSession.shared.data(from: url)
      let infoAndData = try JSONDecoder().decode(InfoAndData.self, from: jsonData)
      return infoAndData
    } catch {
      return nil
    }
  }
}
