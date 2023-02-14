//
//  ViewController.swift
//  NASAAPOD
//
//  Created by Malik Em on 10.02.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setConstraints()
    }
    
    private lazy var photo: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = .systemGray
        
        return imageView
    }()
    
    private lazy var titleOfPhoto: UIButton = {
        let btn = UIButton()
        
        btn.setTitle("Hi", for: .normal)
        btn.backgroundColor = .yellow
        
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
        title = "hello"
        
        view.backgroundColor = .white
        
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
    
}
