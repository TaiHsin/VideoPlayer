//
//  VideoInfoFetcher.swift
//  VideoPlayer
//
//  Created by Taihsin L on 2024/10/14.
//

import AVFoundation
import UIKit
import Combine

struct VideoInfoFetcher {
	static func fetchImage(for videoURL: URL, at timeInSeconds: Double = 2) -> AnyPublisher<UIImage, Error> {
		return Future { promise in
			Task {
				do {
					let asset = AVURLAsset(url: videoURL)
					let generator = AVAssetImageGenerator(asset: asset)
					generator.appliesPreferredTrackTransform = true
					let time = CMTime(seconds: timeInSeconds, preferredTimescale: 60)
					
					let cgImage = try await generator.image(at: time).image
					let uiImage = UIImage(cgImage: cgImage)
					
					promise(.success(uiImage))
				} catch {
					promise(.failure(error))
				}
			}
		}
		.receive(on: DispatchQueue.main)
		.eraseToAnyPublisher()
	}
	
	static func fetchTitle(for videoURL: URL) -> AnyPublisher<String, Error> {
		return Future { promise in
			Task {
				do {
					let asset = AVURLAsset(url: videoURL)
					let metadata = try await asset.load(.metadata)
					
					let title = try await metadata
						.first { $0.commonKey == .commonKeyTitle }?
						.load(.stringValue) ?? ""

					// Return the fetched information
					promise(.success(title))
				} catch {
					promise(.failure(error))
				}
			}
		}
		.receive(on: DispatchQueue.main)
		.eraseToAnyPublisher()
	}
}
