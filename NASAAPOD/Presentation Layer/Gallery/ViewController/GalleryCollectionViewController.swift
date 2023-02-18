//
//  GalleryCollectionViewController.swift
//  NASAAPOD
//
//  Created by Malik Em on 16.02.2023.
//

import UIKit

final class GalleryViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private var viewModels = [APODViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        fetchData()
    }
    
    private func configureView() {
        title = "Gallery of APOD"
        collectionView.backgroundColor = UIColor((#colorLiteral(red: 0.5764705882, green: 0.7490196078, blue: 0.8117647059, alpha: 1)))
        collectionView.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.identifier)
    }
    
    private func fetchData() {
        NetworkManager.shared.getAPOD { [weak self] result in
            switch result {
            case .success(let photos):
                self?.viewModels = photos.compactMap({
                    APODViewModel (
                        copyright: $0.copyright ?? "",
                        date: $0.date ?? "",
                        explanation: $0.explanation ?? "",
                        hdurl: URL(string: $0.hdurl ?? ""),
                        title: $0.title ?? ""
                    )
                })
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
                self?.viewModels.reverse()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension GalleryViewController {
        
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.identifier, for: indexPath) as? GalleryCollectionViewCell else { fatalError() }
    
        cell.backgroundColor = UIColor((#colorLiteral(red: 0.3764705882, green: 0.5882352941, blue: 0.7058823529, alpha: 1)))
        cell.layer.cornerRadius = 20
        cell.configure(with: viewModels[indexPath.item])
       
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let photoDetailsVC = GalleryDetailsViewController()
        photoDetailsVC.detailItem = viewModels[indexPath.item]
        photoDetailsVC.navigationController?.title = navigationController?.title
        
        navigationController?.pushViewController(photoDetailsVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 100, height: view.frame.width - 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
