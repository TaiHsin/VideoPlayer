//
//  URLInputTextField.swift
//  VideoPlayer
//
//  Created by Taihsin L on 2024/10/9.
//

import SwiftUI

struct URLInputTextField: View {
	@State var text: String = ""

	var body: some View {

		ZStack(alignment: .bottom) {
			TextField(" Input video url and play", text: $text, axis: .vertical)
				.padding(.trailing, 25)
				.padding(9)
				.background(
					RoundedRectangle(cornerRadius: 25)
						.stroke(lineWidth: 1.0)
						.foregroundStyle(Color(uiColor: .clear))
						.background(
							Color.gray.opacity(0.1)
								.clipShape(RoundedRectangle(cornerRadius: 25))
						)
				)

			HStack(alignment: .bottom) {
				Spacer()
				
				Button {
					// TODO: Button click action
					print("Button clicked")
				} label: {
					Image(systemName: "arrow.up.circle.fill")
						.foregroundColor(Color(uiColor: .systemBlue))
						.font(.title)
						.padding(.trailing, 3)
				}
			}
			.padding(.bottom, 5)
		}
		.padding(10)
    }
}

#Preview {
    URLInputTextField()
}
