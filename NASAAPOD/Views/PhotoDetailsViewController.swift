//
//  PhotoDetailsViewController.swift
//  NASAAPOD
//
//  Created by Malik Em on 17.02.2023.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    
    var detailItem: APODViewModel?
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .medium)
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let img = UIImageView()
        
        img.layer.masksToBounds = false
    
        return img
    }()
    
    private lazy var titleOfPhoto: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var descrOfPhoto: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var copyright: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .light)
        
        return label
    }()
    
    private lazy var stackContentView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            dateLabel,
            imageView,
            titleOfPhoto,
            descrOfPhoto,
            copyright
        ])
        
        sv.axis = .vertical
        sv.distribution = .fill
        sv.spacing = 8.0
        
        return sv
    }()
    
    private func setConstraints() {
        [dateLabel, imageView, titleOfPhoto, descrOfPhoto, copyright].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.addSubview(stackContentView)
        
        stackContentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            stackContentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            stackContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            stackContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0)
        ])
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor((#colorLiteral(red: 0.5764705882, green: 0.7490196078, blue: 0.8117647059, alpha: 1)))
        configureDate()
        setConstraints()
    }
    
    private func configureDate() {
        guard let date =  detailItem?.date,
              let title = detailItem?.title,
              let descr = detailItem?.explanation,
              let copy = detailItem?.copyright
        else {
            return
        }

        if let data = detailItem?.imageData {
            imageView.image = UIImage(data: data)
        }
        else if let url = detailItem?.hdurl {
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }.resume()
        }
        
        dateLabel.text = date
        titleOfPhoto.text = title
        descrOfPhoto.text = descr
        copyright.text = "©: \(copy)"
    }   
}
