//
//  RESTTasks.swift
//  AssignmentSaltSide
//
//  Created by Sowmiya on 01/03/21.
//

import Foundation

class RESTTask: RESTTaskUtil {
    
    //MARK: Get Items from api
    func getItems(completion: @escaping RESTConstants.TaskCompletionHandler) {
        let itemUrlString = "https://gist.githubusercontent.com/ashwini9241/6e0f26312ddc1e502e9d280806eed8bc/raw/7fab0cf3177f17ec4acd6a2092fc7c0f6bba9e1f/saltside-json-data"
        if let itemUrl = URL(string: itemUrlString) {
            let urlRequest = URLRequest(url: itemUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: RESTConstants.TimeoutInterval)
            get(request: urlRequest, completion: completion)
        } else {
            completion(false,nil,nil)
        }
        
    }
}
