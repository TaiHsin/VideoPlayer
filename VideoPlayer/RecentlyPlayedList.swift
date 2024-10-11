//
//  RecentlyPlayedList.swift
//  VideoPlayer
//
//  Created by Taihsin L on 2024/10/11.
//

import SwiftUI

struct RecentlyPlayedList: View {
	@State var videos: [Video]

	var body: some View {
		List(videos) { video in
			Button {
				// TODO: Button action
				print("VideoThumbnailItem tapped")
			} label: {
				VideoThumbnailItem(video: video)
			}
			.listRowSeparator(.hidden)
		}
		.listStyle(PlainListStyle())
		.navigationTitle("Recent Played Videos")
		.navigationBarTitleDisplayMode(.inline)
	}
}

#Preview {
	RecentlyPlayedList(videos: Video.mocks)
}
