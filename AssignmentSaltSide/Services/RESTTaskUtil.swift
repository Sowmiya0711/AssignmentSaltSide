//
//  RESTTaskUtil.swift
//  AssignmentSaltSide
//
//  Created by Sowmiya on 01/03/21.
//

import Foundation

class RESTTaskUtil: NSObject {
    var url: URL?
    
    private var sessionTask: URLSessionTask?
    private var cachedCompletionHandler: RESTConstants.TaskCompletionHandler?
    
    init(withURL url: URL?) {
        self.url = url
    }
    
    convenience init(withURLString urlString: String) {
        self.init(withURL: URL(string: urlString))
    }
    
    convenience override init() {
        self.init(withURLString: "https://gist.githubusercontent.com/ashwini9241/6e0f26312ddc1e502e9d280806eed8bc/raw/7fab0cf3177f17ec4acd6a2092fc7c0f6bba9e1f/saltside-json-data")
    }
    
    //MARK: DataTask Functionality
    func dataTask(request urlRequest: URLRequest,method: String,completion: @escaping RESTConstants.TaskCompletionHandler) {
        var request = urlRequest
        request.httpMethod = method
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = [ RESTTaskUtilConstants.DataTaskAdditionalHeader.accept: RESTTaskUtilConstants.DataTaskAdditionalHeader.applicationJson,
                                         RESTTaskUtilConstants.DataTaskAdditionalHeader.contentType: RESTTaskUtilConstants.DataTaskAdditionalHeader.applicationUrlEncoded]
        let session = URLSession(configuration: config)
        self.cachedCompletionHandler = completion
        sessionTask = session.dataTask(with: request) { (data,response,error) -> Void in
            if let urlError = error as? URLError, urlError.code != URLError.cancelled {
                self.cachedCompletionHandler = nil
            }
            
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let response = response as? HTTPURLResponse {
                if 200...299 ~= response.statusCode {
                    self.handle(response: response, json: json, data: data, status: true, error: error, completion: completion)
                } else {
                    print(response.statusCode)
                    self.handle(response: response, json: json, data: data, status: false, error: error, completion: completion)
                }
                    
            } else {
                completion(false,data,error)
            }
            
        } else {
            completion(false,nil,error)
        }
        }
        sessionTask?.resume()
    }
    
    //MARK: GET Method
    func get(request: URLRequest,completion: @escaping RESTConstants.TaskCompletionHandler) {
        dataTask(request: request, method: "GET", completion: completion)
    }
    
    private func stringFrom(data: Data) -> String? {
        return String(data: data,encoding: String.Encoding.utf8)
    }
    
    private func handle(response: HTTPURLResponse,json: Any?,data: Data,status: Bool,error: Error?,completion: RESTConstants.TaskCompletionHandler) {
        if json == nil {
            if let contentType = response.allHeaderFields[RESTConstants.HeaderContentType] as? String,contentType.contains(RESTConstants.TypeHTML) {
                completion(status,data,error)
            } else if let responseText = self.stringFrom(data: data) {
                completion(status,responseText,error)
            } else {
                completion(status,data,error)
            }
        } else {
            completion(status,json,error)
        }
    }
}
