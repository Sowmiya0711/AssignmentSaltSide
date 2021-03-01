//
//  ViewController.swift
//  AssignmentSaltSide
//
//  Created by CSS on 01/03/21.
//

import UIKit

class ViewController: BaseViewController {

    @IBOutlet weak var itemTableView: UITableView!
    
    let restTask = RESTTask()
    
    var itemDataModel: [ItemModel]?
    
    var currentDataSource: UITableViewDataSource? {
        didSet {
            self.itemTableView.dataSource = currentDataSource
            self.itemTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showActivityAndDisableInteractionOnMainQueue()
       restTask.getItems(completion: {[weak self] (Success,response,error) in
        DispatchQueue.main.async {
            if Success {
                
                let jsonData = try? JSONSerialization.data(withJSONObject: response as Any)
                self?.itemDataModel = try? JSONDecoder().decode([ItemModel].self, from: jsonData!)
                if let itemDataModel = self?.itemDataModel {
                    self?.currentDataSource = ItemTableViewDataSource(itemsData: itemDataModel)
                }
            } else {
                print(Success)
            }
        }
        self?.hideActivityAndDisableInteractionOnMainQueue()
        })
      
       
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
}
