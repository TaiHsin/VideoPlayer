//
//  Video.swift
//  VideoPlayer
//
//  Created by Taihsin L on 2024/10/14.
//

import UIKit

struct Video: Identifiable {
	let id: UUID
	let url: URL
	var thumbnail: UIImage? = nil
	var title: String
}

#if DEBUG
extension Video {
	static var mock: Self {
		.init(id: .init(),
			  url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!,
			  title: "Big Buck Bunny"
		)
	}
	
	static var mocks: [Self] {
		[
			.init(id: .init(), url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4")!, title: "We Are Going On Bullrun"),
			.init(id: .init(), url: URL(string: "https://www.w3schools.com/html/mov_bbb.mp4")!, title: "bbb"),
			.init(id: .init(), url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!, title: "Big Buck Bunny")
		]
	}
}
#endif
