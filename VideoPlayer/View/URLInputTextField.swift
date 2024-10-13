//
//  URLInputTextField.swift
//  VideoPlayer
//
//  Created by Taihsin L on 2024/10/9.
//

import SwiftUI

struct URLInputTextField: View {
	private let viewModel: TextFieldViewModel
	@ObservedObject var output: TextFieldOutput
	
	init(viewModel: TextFieldViewModel = .init()) {
		self.viewModel = viewModel
		self.output = viewModel.output
	}

	var body: some View {

		ZStack(alignment: .bottom) {
			TextField(" Input video url and play",
					  text: Binding(
						get: { output.urlText },
						set: { viewModel.input.textChanged.send($0) }
					  ),
					  axis: .vertical)
			.padding(.trailing, 25)
			.padding(9)
			.background(
				RoundedRectangle(cornerRadius: 25)
					.stroke(lineWidth: 1.0)
					.foregroundStyle(Color(uiColor: .clear))
					.background(Color.gray.opacity(0.1)
						.clipShape(RoundedRectangle(cornerRadius: 25)))
			)

			HStack(alignment: .bottom) {
				Spacer()
				
				Button {
					viewModel.input.buttonDidTapSubject.send()
				} label: {
					Image(systemName: "play.circle")
						.foregroundColor(Color(uiColor: .systemBlue))
						.font(.title)
						.padding(.trailing, 3)
				}
			}
			.padding(.bottom, 5)
			.fullScreenCover(isPresented: Binding<Bool>(
				get: { viewModel.output.selectedVideoURL != nil },
				set: { isPresented in
					if !isPresented {
						viewModel.input.textChanged.send("")
					}
				}
			)) {
				if let videoURL = viewModel.output.selectedVideoURL {
					PlayerView(viewModel: .init(video: .init(id: .init(), url: videoURL, title: "yoyoyo")))
				}
			}
		}
		.padding(10)
    }
}

#Preview {
    URLInputTextField()
}
