//
//  ItemTableViewDataSource.swift
//  AssignmentSaltSide
//
//  Created by Sowmiya on 01/03/21.
//

import Foundation
import UIKit

class ItemTableViewDataSource: NSObject,UITableViewDataSource {
    var itemsData = [ItemModel]()
    
    init(itemsData: [ItemModel]) {
        self.itemsData = itemsData
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

