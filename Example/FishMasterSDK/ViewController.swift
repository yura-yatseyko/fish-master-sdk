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
        test.testPrint()
        test.testAdd(a: 6, b: 9)
    }

}

