//
//  UIImageView+Extension.swift
//  AssignmentSaltSide
//
//  Created by Sowmiya on 01/03/21.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString,NSData>()

extension UIImage {
    static func loadImageUsingCacheWithUrlString(_ urlString: String, completion: @escaping (UIImage) -> Void) {
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            completion(cachedImage)
        }
       
        //MARK: No cache, so create new one and set image
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if let error = error {
                print(error)
                return
            }

            DispatchQueue.main.async(execute: {
                if let data = data ,let downloadedImage = UIImage(data: data) {
                    imageCache.setObject(data as NSData, forKey: urlString as NSString)
                    completion(downloadedImage)
                }
            })

        }).resume()
    }
}
