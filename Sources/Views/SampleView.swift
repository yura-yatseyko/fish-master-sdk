//
//  SampleView.swift
//  FishMasterSDK
//
//  Created by Yatseyko Yuriy on 1/20/20.
//

import UIKit

public protocol SampleViewProtocol {
    func action(with url: URL)
}

public class SampleView: UIView {
    
    //MARK: - Private variables
    private let testImgUrl = "https://sevstar.net/wp-content/uploads/2018/11/%D0%91%D0%B0%D0%BD%D0%BD%D0%B5%D1%80-%D0%92%D0%B8%D0%B4%D0%B5%D0%BE%D0%BA%D0%B0%D0%BC%D0%B5%D1%80%D1%8B-%D1%84%D0%BE%D0%BD.png"
    
    private var network: Network? = nil
    private var sample: Sample? = nil
    
    //MARK: - Public variables
    public var delegate: SampleViewProtocol? = nil
    
    
    //MARK: - Constructors
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
    
    //MARK: - UI elements
    private lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = UIColor.red
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        imageView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(imageView)
        
        let trailing = NSLayoutConstraint(item: imageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: imageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        
        let height = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)

        NSLayoutConstraint.activate([leading, trailing, top, bottom, height])

        return imageView
    }()
    
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

        NSLayoutConstraint.activate([leading, trailing, top])

        return label
    }()
    
    private lazy var actionBUtton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = UIColor.clear
        
        button.addTarget(self, action: #selector(SampleView.actionButtonTapped(sender:)), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(button)
        
        let trailing = NSLayoutConstraint(item: button, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)

        NSLayoutConstraint.activate([leading, trailing, top, bottom])

        return button
    }()
    
    //MARK: - Public methods
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
    
    //MARK: - Private methods
    private func updateComtent(with sample: Sample) {
        DispatchQueue.main.async { [weak self] in
            
            self?.sample = sample
            
            self?.titleLabel.text = sample.data.titleCopy
            self?.bodyLabel.text = sample.data.bodyCopy
            
            if let imageUrl = URL(string: self?.testImgUrl ?? ""), let network = self?.network {
                network.downloadImage(from: imageUrl) { (data, _, error) in
                    if let imgData = data {
                        let img = UIImage(data: imgData)
                        DispatchQueue.main.async { [weak self] in
                            self?.bannerImageView.image = img
                            self?.bringSubview(toFront: self!.titleLabel)
                            self?.bringSubview(toFront: self!.bodyLabel)
                            self?.bringSubview(toFront: self!.actionBUtton)
                        }
                    }
                }
            }

            self?.layoutIfNeeded()
        }
    }
    
    //MARK: - Actions
    @objc func actionButtonTapped(sender: UIButton!) {
        guard let sample = self.sample else { return }
        
        if let actionUrl = URL(string: sample.actionLink) {
            delegate?.action(with: actionUrl)
        }
    }

}
