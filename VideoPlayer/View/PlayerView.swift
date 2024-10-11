//
//  PlayerView.swift
//  VideoPlayer
//
//  Created by Taihsin L on 2024/10/4.
//

import SwiftUI
import Combine
import AVKit

struct PlayerView: View {
	private let viewModel: PlayerViewModel
	@ObservedObject private var output: PlayerOutput
	
	init(viewModel: PlayerViewModel = .init()) {
		self.viewModel = viewModel
		self.output = viewModel.output
	}
	
    var body: some View {
		VideoPlayer(player: output.player)
			.onAppear {
				viewModel.input.playPauseSubject.send(true)
			}
    }
}

#Preview {
	PlayerView()
}
