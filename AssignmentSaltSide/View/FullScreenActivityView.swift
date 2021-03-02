//
//  FullScreenActivityView.swift
//  AssignmentSaltSide
//
//  Created by Sowmiya on 01/03/21.
//

import Foundation
import UIKit

class FullScreenActivityView: UIImageView {
    override var isHidden: Bool {
        didSet {
            isHidden ? activityIndicator.stopAnimating() : activityIndicator.startAnimating()
        }
    }
    
    private var activityIndicator: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.lightGray
        self.alpha = 0.5
        initAndAddActivityIndicator()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initAndAddActivityIndicator()
    }
    
    //MARK: Setting activityIndicator
    private func initAndAddActivityIndicator() {
        if #available(iOS 13.0, *) {
            activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
            
        } else {
            activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        }
        activityIndicator.color = UIColor.black
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = center
        addSubview(activityIndicator)
    }
}

