// Copyright © 2024 Josh Adams. All rights reserved.

import SwiftUI

struct BrowseCharsView: View {
  @State private var viewModel = BrowseCharsViewModel()
  @State private var images: [String: UIImage] = [:]
  private let imageWidthHeight = 150.0
  private let imageLoader = ImageLoader()

  var body: some View {
    NavigationStack {
      Group {
        switch viewModel.state {
        case .loading:
          ProgressView()
        case .error:
          Image(systemName: "cloud.drizzle")
        case .loaded:
          listOfChars()
        }
      }
      .navigationTitle("Characters")
    }
    .task {
      await viewModel.startLoading()
    }
  }

  func listOfChars() -> some View {
    List {
      ForEach(viewModel.disChars, id: \.id) { disChar in
        NavigationLink {
          CharDetailsView(disChar: disChar, imageLoader: imageLoader)
        } label: {
          HStack {
            Text(disChar.name)

            Spacer()

            Group {
              if let image = images[disChar.name] {
                Image(uiImage: image)
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .padding()
              } else {
                ProgressView()
              }
            }
            .task {
              if
                let urlString = disChar.imageURL,
                let url = URL(string: urlString)
              {
                images[disChar.name] = await imageLoader.load(url: url)
              }
            }
            .frame(width: imageWidthHeight, height: imageWidthHeight)
          }
        }
      }

      if viewModel.hasMoreData {
        HStack {
          Text("LOADING")
          ProgressView()
        }
        .task {
          await viewModel.loadMoreData()
        }
      }
    }
  }
}

#Preview {
  BrowseCharsView()
}
