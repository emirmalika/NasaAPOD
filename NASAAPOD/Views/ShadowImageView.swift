//
//  ShadowImageView.swift
//  NASAAPOD
//
//  Created by Malik Em on 15.02.2023.
//

import UIKit

final class ShadowImageView: UIView {
    
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var baseView: UIView = {
        let imageView = UIView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 5, height: 5)
        imageView.layer.shadowOpacity = 0.7
        imageView.layer.shadowRadius = 10.0
        
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(baseView)
        baseView.addSubview(imageView)
        
        setConstraints()
    }
    
    func setConstraints() {
        [baseView, imageView].forEach { (view) in
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
                view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
                view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
                view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0)
            ])
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        baseView.layer.shadowPath = UIBezierPath(roundedRect: baseView.bounds, cornerRadius: 10.0).cgPath
        baseView.layer.shouldRasterize = true
        baseView.layer.rasterizationScale = UIScreen.main.scale
    }
}
