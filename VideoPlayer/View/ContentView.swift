//
//  ContentView.swift
//  VideoPlayer
//
//  Created by Taihsin L on 2024/9/28.
//

import SwiftUI

struct ContentView: View {
	let urlTextFieldViewModel = URLTextFieldViewModel()

    var body: some View {
        VStack {
			URLTextField(viewModel: urlTextFieldViewModel)
			RecentlyPlayedList(viewModel: .init(inputURLPublisher: urlTextFieldViewModel.output.inputVideoURLPublisher))
		}
        .padding()
    }
}

#Preview {
    ContentView()
}
