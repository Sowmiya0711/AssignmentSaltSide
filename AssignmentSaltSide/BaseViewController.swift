//
//  BaseViewController.swift
//  AssignmentSaltSide
//
//  Created by Sowmiya on 01/03/21.
//

import UIKit

class BaseViewController: UIViewController {

    var fullScreenActivityView: FullScreenActivityView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    //MARK: Show activity indicator
    func showActivityAndDisableInteraction() {
        if let window = UIApplication.shared.keyWindow {
            if fullScreenActivityView == nil {
            let activityView = FullScreenActivityView(frame: UIScreen.main.bounds)
            fullScreenActivityView = activityView
            window.addSubview(activityView)
            
        }
        fullScreenActivityView?.isHidden = false
        DispatchQueue.main.async(execute: {
            window.isUserInteractionEnabled = false
        })
        }
    }
    
    //MARK: Hide activity indicator
    func hideActivityAndDisableInteraction() {
        if let window = UIApplication.shared.keyWindow {
            fullScreenActivityView?.isHidden = true
            DispatchQueue.main.async(execute: {
                window.isUserInteractionEnabled = true
            })
        }
    }
    
    func showActivityAndDisableInteractionOnMainQueue() {
        DispatchQueue.main.async {
            self.showActivityAndDisableInteraction()
        }
    }
    
    func hideActivityAndDisableInteractionOnMainQueue() {
        DispatchQueue.main.async {
            self.hideActivityAndDisableInteraction()
        }
    }
}
