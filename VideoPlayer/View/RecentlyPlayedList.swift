//
//  RecentlyPlayedList.swift
//  VideoPlayer
//
//  Created by Taihsin L on 2024/10/11.
//

import SwiftUI

struct RecentlyPlayedList: View {
	private let viewModel: RecentlyPlayedViewModel
	@ObservedObject var output: RecentlyPlayedOutput

	init(viewModel: RecentlyPlayedViewModel = .init()) {
		self.viewModel = viewModel
		self.output = viewModel.output
	}

	var body: some View {
		NavigationView {
			List {
				ForEach($output.videos) { $video in
					VideoThumbnailItem(video: $video)
						.onTapGesture {
							viewModel.input.itemDidTapSubject.send(video)
						}
						.padding(.bottom, 8)
						.listRowSeparator(.hidden)
				}
				.onDelete {
					viewModel.input.deleteVideoSubject.send($0)
				}
			}
			.listStyle(PlainListStyle())
			.navigationTitle("Recently Played Videos")
			.navigationBarTitleDisplayMode(.inline)
			.fullScreenCover(isPresented: Binding<Bool>(
				get: { output.selectedVideo != nil },
				set: { isPresented in
					if !isPresented {
						viewModel.input.itemDidTapSubject.send(nil)
					}
				}
			)) {
				if let video = output.selectedVideo {
					PlayerView(viewModel: .init(video: video))
				}
			}
		}
	}
}

#Preview {
	RecentlyPlayedList()
}
