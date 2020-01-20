//
//  Constants.swift
//  FishMasterSDK
//
//  Created by Yatseyko Yuriy on 1/20/20.
//

import Foundation

enum BaseServerURL: String {
    case staging = "https://caboo-app-service-stage.herokuapp.com"
}

struct Constants {
    
    static let serverUrl: BaseServerURL = BaseServerURL.staging

}
