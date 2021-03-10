//
//  DownloadAvatarUseCase.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import UIKit
import CoreData

protocol DownloadAvatarUseCase {
    func download(completion: @escaping (UIImage) -> Void)
}

class DownloadAvatarUseCaseImpl: DownloadAvatarUseCase {
    
    private let urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    func download(completion: @escaping (UIImage) -> Void) {
        let imageCache = NSCache<NSString, UIImage>()
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            completion(cachedImage)
        }
        guard let url = URL(string: urlString) else { return }
        Service.downloadImageAndCache(from: url) { imageData in
            guard let image = UIImage(data: imageData) else { return }
            imageCache.setObject(image, forKey: NSString(string: self.urlString))
            self.saveImageDataToDisk(imageData, for: self.urlString)
            completion(image)
        }
    }
    
    private func saveImageDataToDisk(_ imageData: Data, for imageUrlString: String) {
        let userFetchRequest: NSFetchRequest<UserCoreDataEntity> = UserCoreDataEntity.fetchRequest()
        do
        {
            let result = try PersistantManager.context.fetch(userFetchRequest)
            let model = result.first(where: {$0.imageUrl == imageUrlString })
            model?.setValue(imageData, forKey: "image")
            PersistantManager.saveContext()
        }
        catch {
            print("error")
        }
    }
}
 
