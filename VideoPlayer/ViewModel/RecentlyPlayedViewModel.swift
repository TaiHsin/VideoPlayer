//
//  RecentlyPlayedViewModel.swift
//  VideoPlayer
//
//  Created by Taihsin L on 2024/10/14.
//

import Combine

struct RecentlyPlayedInput {
	let itemDidTapSubject = PassthroughSubject<Video?, Never>()
}

class RecentlyPlayedOutput: ObservableObject {
	@Published var videos: [Video] = Video.mocks
	@Published var selectedVideo: Video?
}

class RecentlyPlayedViewModel {
	let input = RecentlyPlayedInput()
	let output = RecentlyPlayedOutput()
	
	private var cancellables = Set<AnyCancellable>()
	
	init() {
		input.itemDidTapSubject
			.assign(to: \.selectedVideo, on: output)
			.store(in: &cancellables)
	}
}
