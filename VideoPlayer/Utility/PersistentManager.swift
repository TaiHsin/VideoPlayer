//
//  PersistentManager.swift
//  VideoPlayer
//
//  Created by Taihsin L on 2024/10/15.
//

import CoreData
import UIKit

extension Video {
	func toVideoEntity(context: NSManagedObjectContext) -> VideoEntity {
		let VideoEntity = VideoEntity(context: context)
		VideoEntity.id = id
		VideoEntity.url = url
		VideoEntity.title = title
		VideoEntity.thumbnail = thumbnail?.jpegData(compressionQuality: 1)
		return VideoEntity
	}
}

extension VideoEntity {
	func toVideo() -> Video? {
		guard let id, let url, let title else { return nil }
		return .init(id: id,
					 url: url,
					 thumbnail: (thumbnail != nil) ? UIImage(data: thumbnail!) : nil,
					 title: title)
	}
}

class PersistentManager {
	lazy var persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "VideoPlayerModel")
		container.loadPersistentStores { _, error in
			if let error {
				print("Failed to create NSPersistentContainer")
				assertionFailure()
			}
		}
		return container
	}()
	
	var context: NSManagedObjectContext {
		return persistentContainer.viewContext
	}
	
	func saveVideo(_ video: Video) {
		let _ = video.toVideoEntity(context: context)
		guard context.hasChanges else { return }
		
		do {
			try context.save()
		} catch {
			print("Failed to save video with error: \(error)")
		}
	}
	
	func fetchVideos() -> [Video] {
		let request: NSFetchRequest<VideoEntity> = VideoEntity.fetchRequest()
		
		do {
			let videoEntities = try context.fetch(request)
			return videoEntities.compactMap { $0.toVideo() }
		} catch {
			print("Failed to fetch videos with error: \(error)")
			return []
		}
	}
}

