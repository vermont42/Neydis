// Copyright © 2024 Josh Adams. All rights reserved.

import Observation

@Observable
class BrowseCharsViewModel {
  enum State: Equatable {
    case loading
    case loaded
    case error
  }

  var state = State.loading
  var disChars: [DisChar] = []
  var nextPage = 1
  var pageCount = 0

  var hasMoreData: Bool {
    nextPage <= pageCount
  }

  func startLoading() async {
    state = .loading
    guard let infoAndData = await Loader.loadInfoAndData(page: nextPage) else {
      state = .error
      return
    }
    disChars = infoAndData.disChars
    pageCount = infoAndData.info.totalPages
    nextPage += 1
    state = .loaded
  }

  func loadMoreData() async {
    guard hasMoreData else {
      return
    }

    let iad = await Loader.loadInfoAndData(page: nextPage)
    guard let iad else {
      state = .error
      return
    }
    disChars += iad.disChars
    nextPage += 1
  }
}
