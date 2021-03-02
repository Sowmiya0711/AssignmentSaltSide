//
//  ItemDetailViewController.swift
//  AssignmentSaltSide
//
//  Created by Sowmiya on 02/03/21.
//

import UIKit

class ItemDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var desc: UILabel!
    
    var itemData: ItemModel?
    
    //Download item image and cache
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.title = "Item Details"
        titleLabel.text = itemData?.title
        desc.text = itemData?.description
        postImageURL = itemData?.image
    }
}
