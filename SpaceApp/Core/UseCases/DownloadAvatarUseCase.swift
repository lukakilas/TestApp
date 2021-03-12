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
    private let saveAvatarGateway: SaveAvatarGateway?
    
    init(urlString: String, saveAvatarGateway: SaveAvatarGateway?) {
        self.urlString = urlString
        self.saveAvatarGateway = saveAvatarGateway
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
            self.saveAvatarGateway?.saveImageDataToDisk(imageData, for: self.urlString)
            completion(image)
        }
    }
}
 
