// Copyright © 2024 Josh Adams. All rights reserved.

struct DisChar: Decodable, Identifiable {
  var id: String { name }
  let name: String
  let films: [String]
  let tvShows: [String]
  let sourceURL: String
  let imageURL: String?

  enum CodingKeys: String, CodingKey {
    case films
    case tvShows
    case sourceURL = "sourceUrl"
    case imageURL = "imageUrl"
    case name
  }

  static var mock: DisChar {
    DisChar(
      name: "Air Bud",
      films: ["Air Bud", "Air Bud: Golden Receiver", "Air Bud: World Pup", "Air Bud: Seventh Inning Fetch", "Air Bud: Spikes Back", "Air Buddies", "Snow Buddies", "Space Buddies", "Santa Buddies", "Ralph Breaks the Internet"],
      tvShows: [],
      sourceURL: "https://disney.fandom.com/wiki/Air_Bud_(dog)",
      imageURL: "https://static.wikia.nocookie.net/disney/images/3/3c/Buddy_%28Air_Bud%29.png")
  }
}
