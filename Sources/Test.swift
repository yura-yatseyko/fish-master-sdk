//
//  Test.swift
//  FishMasterSDK
//
//  Created by Yatseyko Yuriy on 1/20/20.
//

import Foundation

public class Test: NSObject {
    
    public func printBaseServerUrl() {
        print("Base server URL: " + Constants.serverUrl.rawValue)
    }
    
    public func testNetworkClass() {
        let network = Network(key: "123456788", secret: "12894198247189")
        
        let params = [
            "spaceId": "slkdfslknlsknsdkvnsl"
        ] as [String : AnyObject]
        
        network.post(with: "/test/serve/samplead", params: params, success: { (res: Sample) in
            print(res)
        }) { (requestError) in
            print(requestError)
        }
    }
    
}
