//
//  URLTextFieldViewModel.swift
//  VideoPlayer
//
//  Created by Taihsin L on 2024/10/13.
//

import Combine
import UIKit

struct URLTextFieldInput {
	let buttonDidTapSubject = PassthroughSubject<Void, Never>()
	let textChanged = PassthroughSubject<String, Never>()
}

class URLTextFieldOutput: ObservableObject {
	@Published var urlText: String = ""
	@Published var selectedVideoURL: URL?
}

class URLTextFieldViewModel {
	let input = URLTextFieldInput()
	let output = URLTextFieldOutput()
	
	private let application: UIApplication
	private var cancellables = Set<AnyCancellable>()
	
	init(application: UIApplication = .shared) {
		self.application = application

		input.textChanged
			.assign(to: \.urlText, on: output)
			.store(in: &cancellables)
		
		input.buttonDidTapSubject
			.combineLatest(output.$urlText)
			.map { [application] (_, urlText) -> URL? in
				guard let url = URL(string: urlText),
					  application.canOpenURL(url) else {
					// TODO: Error handling if need
					print("Invalid URL input")
					return nil
				}
				return url
			}
			.assign(to: \.selectedVideoURL, on: output)
			.store(in: &cancellables)
	}
}
