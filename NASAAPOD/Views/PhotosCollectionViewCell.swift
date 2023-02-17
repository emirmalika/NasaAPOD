//
//  PhotosCollectionViewCell.swift
//  NASAAPOD
//
//  Created by Malik Em on 16.02.2023.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PhotosCell"
    
    private lazy var photosImage: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    private lazy var titleOfPhoto: UILabel = {
        let lbl = UILabel()
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.textColor = UIColor((#colorLiteral(red: 0.9333333333, green: 0.9137254902, blue: 0.8549019608, alpha: 1)))
        
        return lbl
    }()
    
    private lazy var dateOfPhoto: UILabel = {
        let lbl = UILabel()
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.textColor = UIColor((#colorLiteral(red: 0.7411764706, green: 0.8039215686, blue: 0.8392156863, alpha: 1)))
        
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func setupView() {
        contentView.addSubview(photosImage)
        contentView.addSubview(titleOfPhoto)
        contentView.addSubview(dateOfPhoto)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    private func setConstraints() {
        
        photosImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photosImage.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            photosImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            photosImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            photosImage.heightAnchor.constraint(equalToConstant: contentView.frame.height - 100)
        ])
        
        NSLayoutConstraint.activate([
            titleOfPhoto.topAnchor.constraint(equalTo: photosImage.bottomAnchor, constant: 10),
            titleOfPhoto.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleOfPhoto.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            dateOfPhoto.topAnchor.constraint(equalTo: titleOfPhoto.bottomAnchor, constant: 8),
            dateOfPhoto.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dateOfPhoto.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dateOfPhoto.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with viewModel: APODViewModel) {
        titleOfPhoto.text = viewModel.title
        dateOfPhoto.text = viewModel.date
//
        if let data = viewModel.imageData {
            photosImage.image = UIImage(data: data)
        }
        else if let url = viewModel.hdurl {
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self.photosImage.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
