//
//  UIViewController+Extension.swift
//  AssignmentSaltSide
//
//  Created by Sowmiya on 02/03/21.
//

import Foundation
import UIKit

enum Storyboard: String {
    case main = "Main"
}

extension UIViewController {
    class func instantiate<T: UIViewController>(appStoryboard: Storyboard) -> T {
        let storyboard = UIStoryboard(name: appStoryboard.rawValue,bundle: nil)
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}
