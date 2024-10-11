//
//  ContentView.swift
//  VideoPlayer
//
//  Created by Taihsin L on 2024/9/28.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack {
			URLInputTextField()
			RecentlyPlayedList(videos: Video.mocks)
		}
        .padding()
    }
}

#Preview {
    ContentView()
}
