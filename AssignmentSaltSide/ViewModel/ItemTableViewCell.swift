//
//  ItemTableViewCell.swift
//  AssignmentSaltSide
//
//  Created by Sowmiya on 01/03/21.
//

import Foundation
import UIKit

class ItemTableViewCell: UITableViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    var postImageURL: String? {
            didSet {
                if let url = postImageURL {
                    self.itemImage.image = UIImage(named: "placeholder")

                    UIImage.loadImageUsingCacheWithUrlString(url) { image in
                        // set the image only when we are still displaying the content for the image we finished downloading
                        if url == self.postImageURL {
                            self.itemImage?.image = image
                        }
                    }
                }
                else {
                    self.itemImage?.image = nil
                }
            }
        }
    
    override func awakeFromNib() {
            super.awakeFromNib()
        }
}
