//
//  VideoThumbnailItem.swift
//  VideoPlayer
//
//  Created by Taihsin L on 2024/10/9.
//

import SwiftUI

struct Video: Identifiable {
	let id: UUID
	let url: URL
	var thumbnail: UIImage? = nil
	var title: String
}

#if DEBUG
extension Video {
	static var mock: Self {
		.init(id: .init(),
			  url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!,
			  title: "Big Buck Bunny"
		)
	}
	
	static var mocks: [Self] {
		[
			.init(id: .init(), url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4")!, title: "We Are Going On Bullrun"),
			.init(id: .init(), url: URL(string: "https://www.w3schools.com/html/mov_bbb.mp4")!, title: "bbb"),
			.init(id: .init(), url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!, title: "Big Buck Bunny")
		]
	}
}
#endif

// TODO: Add image fetched error 
struct VideoThumbnailItem: View {
	let video: Video

	var body: some View {
		VStack(alignment: .leading) {
			if let thumbnail = video.thumbnail {
				// Display the thumbnail image
				Image(uiImage: thumbnail)
					.resizable()
					.scaledToFit()
					.aspectRatio(16/9, contentMode: .fit)
					.cornerRadius(8)
					.shadow(radius: 2)
			} else {
				// Placeholder while loading thumbnail
				Rectangle()
					.fill(Color.gray.opacity(0.3))
					.aspectRatio(16/9, contentMode: .fit)
					.cornerRadius(8)
					.overlay(Text("Loading...").foregroundColor(.white))
			}

			// Display video title
			Text(video.title)
				.font(.headline)
				.lineLimit(2)
				.foregroundColor(.primary)
				.padding(.leading, 8)
		}
	}
}

#Preview {
	VideoThumbnailItem(video: .mock)
}
