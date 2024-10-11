//
//  RecentlyPlayedList.swift
//  VideoPlayer
//
//  Created by Taihsin L on 2024/10/11.
//

import SwiftUI

struct RecentlyPlayedList: View {
	@State var videos: [Video]
	@State var selectedVideo: Video?

	var body: some View {
		NavigationView {
			List(videos) { video in
				Button {
					// TODO: Button action
					print("VideoThumbnailItem tapped")
					selectedVideo = video
				} label: {
					VideoThumbnailItem(video: video)
				}
				.listRowSeparator(.hidden)
			}
			.listStyle(PlainListStyle())
			.navigationTitle("Recent Played Videos")
			.navigationBarTitleDisplayMode(.inline)
			.fullScreenCover(isPresented: Binding<Bool>(
				get: { selectedVideo != nil },
				set: { isPresented in
					if !isPresented {
						selectedVideo = nil
					}
				}
			)) {
				if let video = selectedVideo {
					PlayerView(viewModel: .init(video: video))
				}
			}
		}
	}
}

#Preview {
	RecentlyPlayedList(videos: Video.mocks)
}
