//
//  ContentView.swift
//  VideoPlayer
//
//  Created by Taihsin L on 2024/9/28.
//

import SwiftUI
import AVKit

struct ContentView: View {
	@State var player = AVPlayer(url: URL(string: "https://media.w3.org/2010/05/sintel/trailer.mp4")!)

    var body: some View {
        VStack {			
			VideoPlayer(player: player)
				.frame(height: 400)
		}
        .padding()
    }
}

#Preview {
    ContentView()
}
