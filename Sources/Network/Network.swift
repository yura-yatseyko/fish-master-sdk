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
    func post<T>(with path: String, params: [String: AnyObject] = [:], success: @escaping (T) -> (), failed: @escaping (RequestError) -> ()) where T : Codable {
        
        let url = URL(string: baseUrl + path)!

        var request = URLRequest(url: url)
        
        request.httpMethod = RequestMethod.post.rawValue
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var json = params
        json["key"] = (key ?? "") as AnyObject
        json["secret"] = (secret ?? "") as AnyObject
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        
        let task = session.uploadTask(with: request, from: jsonData) { data, response, error in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            
            if let responseError = error {
                failed(RequestError(status: statusCode, errorDescription: responseError.localizedDescription))
            } else {
                if let jsonData = data {
                    
                    let decoder = JSONDecoder()

                    do {
                        let sample = try decoder.decode(T.self, from: jsonData)
                        success(sample)
                    } catch {
                        failed(RequestError(status: statusCode, errorDescription: error.localizedDescription))
                    }
                } else {
                    failed(RequestError(status: statusCode, errorDescription: "Wrong data"))
                }
            }
        }

        task.resume()
    }
    
    func downloadImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        session.dataTask(with: url, completionHandler: completion).resume()
    }
    
}
