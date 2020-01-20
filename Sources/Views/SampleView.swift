//
//  SampleView.swift
//  FishMasterSDK
//
//  Created by Yatseyko Yuriy on 1/20/20.
//

import UIKit

public class SampleView: UIView {
    
    private var network: Network? = nil
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()

        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        label.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(label)

        let trailing = NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -16)
        let leading = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 16)
        let top = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 16)

        NSLayoutConstraint.activate([leading, trailing, top])

        return label
    }()
    
    private lazy var bodyLabel: UILabel = {
        let label = UILabel()

        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor.black
        
        label.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(label)

        let trailing = NSLayoutConstraint(item: label, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -16)
        let leading = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 16)
        let bottom = NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -16)
        let top = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 5)

        NSLayoutConstraint.activate([leading, trailing, bottom, top])

        return label
    }()
    
    public func setConfigs(with key: String, and secret: String) {
        network = Network(key: key, secret: secret)
    }
    
    public func loadContent() {
        guard let network = network else { return }
        
        let params = [
            "spaceId": "slkdfslknlsknsdkvnsl"
        ] as [String : AnyObject]
        
        network.post(with: "/test/serve/samplead", params: params, success: { [weak self] (response: Sample) in
            self?.updateComtent(with: response)
        }) { (requestError) in
            print(requestError)
        }
    }
    
    private func updateComtent(with sample: Sample) {
        DispatchQueue.main.async { [weak self] in
            self?.titleLabel.text = sample.data.titleCopy
            self?.bodyLabel.text = sample.data.bodyCopy

            self?.layoutIfNeeded()
        }
    }

}
