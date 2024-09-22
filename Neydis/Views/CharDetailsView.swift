// Copyright © 2024 Josh Adams. All rights reserved.

import SwiftUI

struct CharDetailsView: View {
  @State var image: UIImage?
  @Environment(\.openURL) var openURL
  private let disChar: DisChar
  private let imageWidthHeight = 250.0
  private let imageLoader: ImageLoader

  var body: some View {
    VStack {
      Text(disChar.name)
        .font(.title)

      Group{
        if let image {
          Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
        } else {
          ProgressView()
        }
      }
      .frame(width: imageWidthHeight, height: imageWidthHeight)
      .task {
        if
          let urlString = disChar.imageURL,
          let url = URL(string: urlString)
        {
          await image = imageLoader.load(url: url)
        }
      }

      Text("Films: \(disChar.films.isEmpty ? "NONE" : disChar.films.joined(separator: ", "))")
        .font(.body)
        .padding()

      Text("TV Shows: \(disChar.tvShows.isEmpty ? "NONE" : disChar.tvShows.joined(separator: ", "))")
        .font(.body)
        .padding()

      Button("Source") {
        if let url = URL(string: disChar.sourceURL) {
          openURL(url)
        }
      }

      Spacer()
    }
  }

  init(disChar: DisChar, imageLoader: ImageLoader) {
    self.disChar = disChar
    self.imageLoader = imageLoader
  }
}

#Preview {
  CharDetailsView(disChar: DisChar.mock, imageLoader: ImageLoader())
}
