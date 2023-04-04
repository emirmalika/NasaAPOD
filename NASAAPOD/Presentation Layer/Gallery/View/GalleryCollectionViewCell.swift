//
//  PhotosCollectionViewCell.swift
//  NASAAPOD
//
//  Created by Malik Em on 16.02.2023.
//

import UIKit

final class GalleryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PhotosCell"
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var titleOfImage: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = UIColor((#colorLiteral(red: 0.9333333333, green: 0.9137254902, blue: 0.8549019608, alpha: 1)))
        return lbl
    }()
    
    private lazy var dateOfImage: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.textColor = UIColor((#colorLiteral(red: 0.7411764706, green: 0.8039215686, blue: 0.8392156863, alpha: 1)))
        return lbl
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.color = UIColor((#colorLiteral(red: 0.7411764706, green: 0.8039215686, blue: 0.8392156863, alpha: 1)))
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func style() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleOfImage)
        contentView.addSubview(dateOfImage)
        contentView.addSubview(activityIndicator)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    private func layout() {
        [imageView, titleOfImage, dateOfImage, activityIndicator].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: contentView.frame.height - 100),
    
            titleOfImage.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            titleOfImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleOfImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
       
            dateOfImage.topAnchor.constraint(equalTo: titleOfImage.bottomAnchor, constant: 8),
            dateOfImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dateOfImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dateOfImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configure(with viewModel: APODViewModel) {
        titleOfImage.text = viewModel.title
        dateOfImage.text = viewModel.date
        if let url = viewModel.hdurl {
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                    self.activityIndicator.stopAnimating()
                }
            }.resume()
        }
    }
}


