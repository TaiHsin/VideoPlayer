//
//  PlayerViewModel.swift
//  VideoPlayer
//
//  Created by Taihsin L on 2024/10/4.
//

import Foundation
import Combine
import AVFoundation

protocol PlayerViewModelType {
	var input: PlayerInput { get }
	var output: PlayerOutput { get }
}

struct PlayerInput {
	let playPauseSubject = PassthroughSubject<Bool, Never>()
}

class PlayerOutput: ObservableObject {
	@Published var player: AVPlayer?
	@Published var isPlayingSubject = CurrentValueSubject<Bool, Never>(false)
}

// TODO: Error handling
class PlayerViewModel: PlayerViewModelType {
	let input = PlayerInput()
	var output = PlayerOutput()
	
	private var playerSubject: CurrentValueSubject<AVPlayer?, Never>
	private var cancellables = Set<AnyCancellable>()
	
	init(video: Video) {
		playerSubject = .init(AVPlayer(url: video.url))
		
		playerSubject
			.assign(to: \.player, on: self.output)
			.store(in: &cancellables)

		input.playPauseSubject
			.sink { [weak self] shouldPlay in
				shouldPlay ?
				self?.playerSubject.value?.play() :
				self?.playerSubject.value?.pause()
			}
			.store(in: &cancellables)
	}
}
