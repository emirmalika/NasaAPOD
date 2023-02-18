//
//  PhotoDetailsViewController.swift
//  NASAAPOD
//
//  Created by Malik Em on 17.02.2023.
//

import UIKit

final class GalleryDetailsViewController: UIViewController {
    
    var detailItem: APODViewModel?
   
    private lazy var dateOfImage: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .medium)
        label.textColor = UIColor((#colorLiteral(red: 0.9333333333, green: 0.9137254902, blue: 0.8549019608, alpha: 1)))
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let img = UIImageView()
        
        img.layer.masksToBounds = false
       
        return img
    }()
    
    private lazy var titleOfImage: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = UIColor((#colorLiteral(red: 0.9333333333, green: 0.9137254902, blue: 0.8549019608, alpha: 1)))
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var descrOfImage: UILabel = {
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
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        
        activityIndicator.style = .large
        activityIndicator.color = UIColor((#colorLiteral(red: 0.7411764706, green: 0.8039215686, blue: 0.8392156863, alpha: 1)))
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        return activityIndicator
    }()
    
    private lazy var stackContentView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            dateOfImage,
            imageView,
            titleOfImage,
            descrOfImage,
            copyright
        ])
        
        sv.axis = .vertical
        sv.distribution = .fill
        sv.spacing = 8.0
        
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        setupView()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureDate()
    }
    
    private func configureView() {
        view.backgroundColor = UIColor((#colorLiteral(red: 0.5764705882, green: 0.7490196078, blue: 0.8117647059, alpha: 1)))
        
        let actionBtn = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(shareBtnTapped))
        actionBtn.tintColor = .black
        
        navigationItem.rightBarButtonItem = actionBtn
    }
    
    @objc func shareBtnTapped() {
        guard let imageURL = detailItem?.hdurl, let imageData = try? Data(contentsOf: imageURL)
        else { return }
        let image: [Any] = [UIImage(data: imageData) as Any]
        
        let shareController = UIActivityViewController(activityItems: image, applicationActivities: nil)
        
        present(shareController, animated: true, completion: nil)
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
                    self.activityIndicator.stopAnimating()
                }
            }.resume()
        }
        
        dateOfImage.text = date
        titleOfImage.text = title
        descrOfImage.text = descr
        copyright.text = "©: \(copy)"
    }
    
    private func setupView() {
        view.addSubview(stackContentView)
        view.addSubview(activityIndicator)
    }
    
    private func setConstraints() {
        [dateOfImage, imageView, titleOfImage, descrOfImage, copyright, stackContentView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
   
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            stackContentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            stackContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            stackContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }
}
