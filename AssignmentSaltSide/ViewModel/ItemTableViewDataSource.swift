//
//  ItemTableViewDataSource.swift
//  AssignmentSaltSide
//
//  Created by CSS on 01/03/21.
//

import Foundation
import UIKit

class ItemTableViewDataSource: NSObject,UITableViewDataSource {
    var itemsData = [ItemModel]()
    
    init(itemsData: [ItemModel]) {
        self.itemsData = itemsData
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(itemsData.count)
        return itemsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath as IndexPath) as? ItemTableViewCell
        cell?.title.text = itemsData[indexPath.row].title
        cell?.desc.text = itemsData[indexPath.row].description
        cell?.postImageURL = itemsData[indexPath.row].image
                return cell ?? UITableViewCell()
    }
}

extension UIImage {
    static func loadImageUsingCacheWithUrlString(_ urlString: String, completion: @escaping (UIImage) -> Void) {
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            completion(cachedImage)
        }
       
        //No cache, so create new one and set image
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
