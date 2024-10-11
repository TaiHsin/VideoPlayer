//
//  PlayerView.swift
//  VideoPlayer
//
//  Created by Taihsin L on 2024/10/4.
//

import SwiftUI
import AVKit

struct PlayerView: View {
	@Environment(\.dismiss) var dismiss
	@ObservedObject private var output: PlayerOutput

	private let viewModel: PlayerViewModel
	
	init(viewModel: PlayerViewModel) {
		self.viewModel = viewModel
		self.output = viewModel.output
	}
	
    var body: some View {
		VStack {
			HStack {
				// TODO: Landscape to hide dismiss button
				Button {
					dismiss()
				} label: {
					Image(systemName: "xmark.circle")
				}
				.font(.title2)
				.foregroundStyle(Color.gray)
				.padding(.leading, 18)
				.padding(.bottom, 4)
				
				Spacer()
			}
			
			VideoPlayer(player: output.player)
				.onAppear {
					viewModel.input.playPauseSubject.send(true)
				}
		}
    }
}

#Preview {
	PlayerView(viewModel: .init(video: .mock))
}
