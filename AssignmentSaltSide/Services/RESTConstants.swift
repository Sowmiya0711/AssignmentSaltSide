//
//  RESTConstants.swift
//  AssignmentSaltSide
//
//  Created by CSS on 01/03/21.
//

import Foundation

struct RESTConstants {
    typealias TaskCompletionHandler = (_ success: Bool,_ object: Any?,_ error: Error?) -> ()
    
    static let HeaderContentType = "Content-Type"
    static let TypeHTML = "text/html"
    static let TimeoutInterval: TimeInterval = 30
    static let TypeJSON = "application/json; charset=utf-8"
}

struct RESTTaskUtilConstants {
    struct DataTaskAdditionalHeader {
        static let accept = "Accept"
        static let applicationJson = "application/json"
        static let contentType = "Content-Type"
        static let applicationUrlEncoded = "application/x-www-form-urlencoded"
    }
    
    struct error {
        static let error = "error"
    }
    
}
