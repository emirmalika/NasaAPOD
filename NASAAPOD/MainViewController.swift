//
//  ViewController.swift
//  NASAAPOD
//
//  Created by Malik Em on 10.02.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    private var photos: APODViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setConstraints()
//        fetchData()
    }

    private lazy var photo: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = .systemGray
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var titleOfPhoto: UIButton = {
        let btn = UIButton()
        
        btn.setTitle("", for: .normal)
        btn.backgroundColor = .darkGray
        
        
        return btn
    }()
    
    private lazy var stackContentView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [photo, titleOfPhoto])
        
        sv.axis = .vertical
        sv.distribution = .fill
        sv.spacing = 8.0
        
        return sv
    }()
    
    private var menu = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: MainViewController.self, action: #selector(menuBtnTapped))
    
    private var share = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: MainViewController.self, action: #selector(shareBtnTapped))
    
    @objc func menuBtnTapped() {
        
    }
    
    @objc func shareBtnTapped() {
        
    }
    
    private func configureView() {
        view.backgroundColor = .systemGray
        
        navigationItem.leftBarButtonItem = menu
        navigationItem.rightBarButtonItem = share
        
        menu.tintColor = .black
        share.tintColor = .black
    }
    
    private func setConstraints() {
        [photo, titleOfPhoto].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.addSubview(stackContentView)
        
        stackContentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            
            stackContentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            stackContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            stackContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            stackContentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100.0)
        ])
    }
    
    
//    private func fetchData() {
//        NetworkManager.shared.getAPOD { [weak self] result in
//            switch result {
//            case .success(let photos):
//                let urlString = photos.hdurl
//                guard let url = URL(string: urlString ?? "") else { return }
//
//                URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
//                    guard let data = data, error == nil else {
//                        return
//                    }
//
//                    DispatchQueue.main.async {
//                        self?.titleOfPhoto.setTitle(photos.title, for: .normal)
//                        self?.photo.image = UIImage(data: data)
//                        self?.navigationItem.title = photos.date
//                    }
//
//                }.resume()
//            case .failure(let error):
//                print(error)
//            }
//
//        }
//    }
}
    

