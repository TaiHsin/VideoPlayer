//
//  URLTextField.swift
//  VideoPlayer
//
//  Created by Taihsin L on 2024/10/9.
//

import SwiftUI

struct URLTextField: View {
	private let viewModel: URLTextFieldViewModel
	@ObservedObject var output: URLTextFieldOutput
	
	init(viewModel: URLTextFieldViewModel = .init()) {
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
			.toolbar {
				ToolbarItem(placement: .keyboard) {
					Button("Done") {
						dismissKeyboard()
					}
				}
			}

			HStack(alignment: .bottom) {
				Spacer()
				
				Button {
					viewModel.input.buttonDidTapSubject.send()
					dismissKeyboard()
				} label: {
					Image(systemName: "play.circle")
						.foregroundColor(Color(uiColor: .systemBlue))
						.font(.title)
						.padding(.trailing, 3)
				}
			}
			.padding(.bottom, 5)
			.fullScreenCover(isPresented: Binding<Bool>(
				get: { output.inputVideoURL != nil },
				set: { isPresented in
					if !isPresented {
						viewModel.input.textChanged.send("")
					}
				}
			)) {
				if let videoURL = output.inputVideoURL {
					PlayerView(viewModel: .init(video: .init(id: .init(), url: videoURL, title: "yoyoyo")))
				}
			}
		}
		.padding(10)
    }
	
	private func dismissKeyboard() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}

#Preview {
    URLTextField()
}
