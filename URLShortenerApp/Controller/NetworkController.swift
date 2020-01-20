//
//  NetworkController.swift
//  URLShortenerApp
//
//  Created by PiPyL on 1/20/20.
//  Copyright © 2020 PiPyL. All rights reserved.
//

import UIKit

class NetworkController: NSObject {
    
    class func getURLShortener(urlString: String, completion: @escaping (_ error: String?, _ urlShortener: String?) -> Void) {
        
        let urlShortenerString = "http://tinyurl.com/api-create.php?url=" + urlString
        
        var request = URLRequest(url: URL(string: urlShortenerString)!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                completion(error?.localizedDescription, nil)
                print(String(describing: error))
                return
            }
            
            if let urlStringRes = String(data: data, encoding: .utf8) {
                completion(nil, urlStringRes)
            } else {
                completion("Error when get url shortener!", nil)
            }
        }
        
        task.resume()
    }
}
