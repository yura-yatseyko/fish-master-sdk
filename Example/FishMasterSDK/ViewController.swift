//
//  ViewController.swift
//  FishMasterSDK
//
//  Created by yura-yatseyko on 01/20/2020.
//  Copyright (c) 2020 yura-yatseyko. All rights reserved.
//

import UIKit
import SafariServices
import FishMasterSDK


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sampleView = SampleView(frame: CGRect.zero)
        view.addSubview(sampleView)
        
        sampleView.delegate = self
        
        let trailing = NSLayoutConstraint(item: sampleView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: sampleView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: sampleView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([leading, trailing, bottom])
        
        sampleView.setConfigs(with: "123456788", and: "12894198247189")
        sampleView.loadContent()
        
    }

}

extension ViewController: SampleViewProtocol {
    func action(with url: URL) {
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
}

