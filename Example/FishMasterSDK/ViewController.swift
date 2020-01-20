//
//  ViewController.swift
//  FishMasterSDK
//
//  Created by yura-yatseyko on 01/20/2020.
//  Copyright (c) 2020 yura-yatseyko. All rights reserved.
//

import UIKit
import FishMasterSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Test method from FishMasterSDK
        let test = Test()
        test.printBaseServerUrl()
        test.testNetworkClass()
        
        let sampleView = SampleView(frame: CGRect.zero)
        view.addSubview(sampleView)
        
        let trailing = NSLayoutConstraint(item: sampleView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: sampleView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: sampleView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([leading, trailing, bottom])
        
        sampleView.setConfigs(with: "123456788", and: "12894198247189")
        sampleView.loadContent()
        
    }

}

