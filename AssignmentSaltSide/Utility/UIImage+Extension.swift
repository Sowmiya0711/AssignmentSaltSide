//
//  UIImageView+Extension.swift
//  AssignmentSaltSide
//
//  Created by CSS on 01/03/21.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString,NSData>()

class AsyncImageView: UIImageView {

private var currentUrl: String? //Get a hold of the latest request url

public func imageFromServerURL(url: String){
    currentUrl = url
    if(imageCache.object(forKey: url as NSString) != nil){
        self.image = imageCache.object(forKey: url as NSString) as? UIImage
    }else{
        
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let task = session.dataTask(with: NSURL(string: url)! as URL, completionHandler: { (data, response, error) -> Void in
            if error == nil {

                DispatchQueue.main.async {
                    if let data = data,let downloadedImage = UIImage(data: data) {
                        if (url == self.currentUrl) {//Only cache and set the image view when the downloaded image is the one from last request
                            imageCache.setObject(data as NSData, forKey: url as NSString)
                            self.image = downloadedImage
                        }

                    }
                }

            }
            else {
                print(error)
            }
        })
        task.resume()
    }

}
}

extension UIImageView {
    func downloadImage(imageUrlString: String) {
        guard let url = URL(string: imageUrlString), let cacheId = imageUrlString.components(separatedBy: "/").last as NSString? else { return }
        if let cachedData = imageCache.object(forKey: cacheId) {
            guard  let image = UIImage(data: cachedData as Data) else {
                return
            }
            
            DispatchQueue.main.async {
                self.image = image
            }
        } else {
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
            print(url)
            session.downloadTask(with: urlRequest) { data,response,error in
                if let httpUrlResponse = response as? HTTPURLResponse {
                    if httpUrlResponse.statusCode == 200 {
                        if let responseUrl = data, let imageData = try? Data(contentsOf: responseUrl) {
                            guard let image = UIImage(data: imageData) else { return }
                            imageCache.setObject(imageData as NSData, forKey: cacheId)
                            DispatchQueue.main.async() {
                                self.image = image
                            }
                        }
                    }
                }
            }.resume()
            self.image = UIImage(named: "")
        }
        
    }
}
