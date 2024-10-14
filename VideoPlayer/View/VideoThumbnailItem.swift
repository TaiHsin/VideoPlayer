//
//  VideoThumbnailItem.swift
//  VideoPlayer
//
//  Created by Taihsin L on 2024/10/9.
//

import SwiftUI

// TODO: Add image fetched error 
struct VideoThumbnailItem: View {
	@Binding var video: Video

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
	VideoThumbnailItem(video: Binding(get: { .mock }, set: { _ in }))
}
