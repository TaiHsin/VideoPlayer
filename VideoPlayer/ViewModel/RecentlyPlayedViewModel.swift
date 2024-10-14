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
	
	private let fetchTitleSubject = PassthroughSubject<Void, Never>()
	private let fetchImagesSubject = PassthroughSubject<Void, Never>()
	private var cancellables = Set<AnyCancellable>()
	
	init() {
		setupBindings()
		fetchVideoInfo()
	}
	
	private func setupBindings() {
		input.itemDidTapSubject
			.assign(to: \.selectedVideo, on: output)
			.store(in: &cancellables)
		
		fetchTitleSubject
			.map { [weak self] in
				self?.output.videos.filter { $0.title.isEmpty } ?? []
			}
			.filter { !$0.isEmpty }
			.flatMap { videosToFetch in
				return Publishers.MergeMany(videosToFetch.map { video in
					VideoInfoFetcher.fetchTitle(for: video.url)
						.map { title -> Video in
							var updatedVideo = video
							updatedVideo.title = title
							return updatedVideo
						}
						.catch { _ in
							// TODO: Error Handling
							Empty<Video, Never>()
						}
				})
				.collect()
				.eraseToAnyPublisher()
			}
			.sink { [weak self] updatedVideos in
				// Update only fetched videos
				updatedVideos.forEach { video in
					if let index = self?.output.videos.firstIndex(where: { $0.id == video.id }) {
						self?.output.videos[index].title = video.title
					}
				}
			}
			.store(in: &cancellables)

		fetchImagesSubject
			.map { [weak self] in
				self?.output.videos.filter { $0.thumbnail == nil } ?? []
			}
			.filter { !$0.isEmpty }
			.flatMap { videosToFetch in
				return Publishers.MergeMany(videosToFetch.map { video in
					VideoInfoFetcher.fetchImage(for: video.url)
						.map { image -> Video in
							var updatedVideo = video
							updatedVideo.thumbnail = image
							return updatedVideo
						}
						.catch { _ in
							// TODO: Error Handling
							Empty<Video, Never>()
						}
				})
				.collect()
				.eraseToAnyPublisher()
			}
			.sink { [weak self] updatedVideos in
				// Update only fetched videos
				updatedVideos.forEach { video in
					if let index = self?.output.videos.firstIndex(where: { $0.id == video.id }) {
						self?.output.videos[index].thumbnail = video.thumbnail
					}
				}
			}
			.store(in: &cancellables)
	}
	
	private func fetchVideoInfo() {
		fetchImagesSubject.send()
		fetchTitleSubject.send()
	}
}
