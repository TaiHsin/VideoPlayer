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
			List(output.videos) { video in
				Button {
					viewModel.input.itemDidTapSubject.send(video)
				} label: {
					VideoThumbnailItem(video: video)
				}
				.padding(.bottom, 8)
				.listRowSeparator(.hidden)
			}
			.listStyle(PlainListStyle())
			.navigationTitle("Recent Played Videos")
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
