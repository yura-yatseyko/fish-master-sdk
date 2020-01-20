//
//  Network.swift
//  FishMasterSDK
//
//  Created by Yatseyko Yuriy on 1/20/20.
//

import Foundation

enum RequestMethod: String {
    case post = "POST"
    case get = "GET"
}

class Network {
    
    private let baseUrl = Constants.serverUrl.rawValue
    
    let session = URLSession.shared
    
    //MARK: - Key and secret
    private var key: String? = nil
    private var secret: String? = nil
    
    //MARK: - Constructors
    init(key: String, secret: String) {
        self.key = key
        self.secret = secret
    }
    
    //MARK: - Requests
    func post(with path: String, params: [String: AnyObject] = [:]) {
        
        let url = URL(string: baseUrl + path)!

        var request = URLRequest(url: url)
        
        request.httpMethod = RequestMethod.post.rawValue
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var json = params
        json["key"] = (key ?? "") as AnyObject
        json["secret"] = (secret ?? "") as AnyObject
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        
        let task = session.uploadTask(with: request, from: jsonData) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
            }
            
            if let jsonData = data {
                let decoder = JSONDecoder()

                do {
                    let sample = try decoder.decode(Sample.self, from: jsonData)
                    print(sample)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }

        task.resume()
    }
    
}
